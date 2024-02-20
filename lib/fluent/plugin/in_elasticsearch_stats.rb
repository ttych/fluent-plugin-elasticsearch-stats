# frozen_string_literal: true

#
# Copyright 2024- Thomas Tych
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'fluent/plugin/input'

require_relative 'elasticsearch_stats'

module Fluent
  module Plugin
    class ElasticsearchStatsInput < Fluent::Plugin::Input
      NAME = 'elasticsearch_stats'
      Fluent::Plugin.register_input(NAME, self)

      helpers :event_emitter, :timer

      DEFAULT_TAG = NAME
      DEFAULT_URLS = ['http://localhost:9200'].freeze
      DEFAULT_TIMEOUT = 10
      DEFAULT_USER_AGENT = NAME

      DEFAULT_INTERVAL = 300

      DEFAULT_CLUSTER_HEALTH = true
      DEFAULT_CLUSTER_HEALTH_LEVEL = :cluster
      DEFAULT_CLUSTER_HEALTH_LOCAL = false

      config_param :tag, :string, default: DEFAULT_TAG, desc: 'tag to emit events on'
      config_param :urls, :array, value_type: :string, default: DEFAULT_URLS, desc: 'list or urls to poll'
      config_param :timeout, :integer, default: DEFAULT_TIMEOUT, desc: 'request timeout'
      config_param :username, :string, default: nil, desc: 'username for basic auth'
      config_param :password, :string, default: nil, desc: 'password for basic auth'
      config_param :user_agent, :string, default: DEFAULT_USER_AGENT, desc: 'request user agent'
      config_param :ca_file, :string, default: nil, desc: 'CA cert file to use for request'
      config_param :verify_ssl, :bool, default: true, desc: 'option to verify certificate/host'

      config_param :interval, :time, default: DEFAULT_INTERVAL, desc: 'interval for probe execution'

      config_param :cluster_health, :bool, default: DEFAULT_CLUSTER_HEALTH, desc: 'collect cluster health events'
      config_param :cluster_health_level, :enum, list: %i[indices cluster shards], default: DEFAULT_CLUSTER_HEALTH_LEVEL,
                                                 desc: 'details level of the health information'
      config_param :cluster_health_local, :bool, default: DEFAULT_CLUSTER_HEALTH_LOCAL,
                                                 desc: 'retrieves information from the local node only'

      def configure(conf)
        super

        raise Fluent::ConfigError, 'tag should not be empty' if tag.empty?
        raise Fluent::ConfigError, 'urls should not be empty' if urls.empty?

        @mutex_emit = Mutex.new
        configure_elasticsearchs
      end

      def configure_elasticsearchs
        @elasticsearchs = []
        urls.each do |url|
          client = ElasticsearchStatsClient.new(
            url: url, timeout: timeout, username: username, password: password,
            user_agent: user_agent, ca_file: ca_file, verify_ssl: verify_ssl,
            log: log
          )
          @elasticsearchs << ElasticsearchStats.new(
            client: client,
            stats_config: self,
            log: log
          )
        end
      end

      def start
        super

        timer_execute(:execute_collect_first, 1, repeat: false, &method(:execute_collect)) if interval > 60

        timer_execute(:execute_collect, interval, repeat: true, &method(:execute_collect))
      end

      def execute_collect
        threads = []
        @elasticsearchs.each do |elasticsearch|
          threads << Thread.new do
            metrics = elasticsearch.collect_stats_metrics
            events = MultiEventStream.new(
              [Fluent::EventTime.now] * metrics.size,
              metrics
            )
            emit_events(events)
          end
        end
        threads.each(&:join)
      end

      def emit_events(events)
        return if !events || events.empty?

        @mutex_emit.synchronize do
          router.emit_stream(tag, eventstream)
        end
      end
    end
  end
end
