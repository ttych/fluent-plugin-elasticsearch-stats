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

      DEFAULT_TIMESTAMP_FORMAT = :iso

      DEFAULT_CLUSTER_HEALTH = true
      DEFAULT_CLUSTER_HEALTH_LEVEL = :cluster
      DEFAULT_CLUSTER_HEALTH_LOCAL = false
      DEFAULT_CLUSTER_STATS = true
      DEFAULT_NODES_STATS = true
      DEFAULT_NODES_STATS_LEVEL = :node
      DEFAULT_NODES_STATS_METRICS = nil
      DEFAULT_INDICES_STATS = true
      DEFAULT_INDICES_STATS_LEVEL = :indices
      DEFAULT_INDICES = nil
      DEFAULT_SHARDS_STATS = true
      DEFAULT_DANGLING = false
      DEFAULT_INDEX_BASE_PATTERN = nil # '/(.*)/'
      DEFAULT_INDEX_BASE_REPLACEMENT = '\1'
      DEFAULT_EVENT_NAME_SEPARATOR = '/'
      DEFAULT_SKIP_SYSTEM_INDICES = true

      ALLOWED_CLUSTER_HEALTH_LEVELS = Fluent::Plugin::ElasticsearchStats::Client::ALLOWED_CLUSTER_HEALTH_LEVELS
      ALLOWED_NODES_STATS_LEVELS =  Fluent::Plugin::ElasticsearchStats::Client::ALLOWED_NODES_STATS_LEVELS
      ALLOWED_INDICES_STATS_LEVELS = Fluent::Plugin::ElasticsearchStats::Client::ALLOWED_INDICES_LEVELS

      desc 'tag to emit events on'
      config_param :tag, :string, default: DEFAULT_TAG
      desc 'list or urls to poll'
      config_param :urls, :array, value_type: :string, default: DEFAULT_URLS
      desc 'request timeout'
      config_param :timeout, :integer, default: DEFAULT_TIMEOUT
      desc 'username for basic auth'
      config_param :username, :string, default: nil
      desc 'password for basic auth'
      config_param :password, :string, default: nil
      desc 'request user agent'
      config_param :user_agent, :string, default: DEFAULT_USER_AGENT
      desc 'CA cert file to use for request'
      config_param :ca_file, :string, default: nil
      desc 'option to verify certificate/host'
      config_param :verify_ssl, :bool, default: true

      desc 'interval for probe execution'
      config_param :interval, :time, default: DEFAULT_INTERVAL

      desc 'prefix for metric fields'
      config_param :metric_prefix, :string, default: nil
      desc 'prefix for metadata fields'
      config_param :metadata_prefix, :string, default: nil
      desc 'event timestamp format'
      config_param :timestamp_format, :enum, list: %i[iso epochmillis], default: DEFAULT_TIMESTAMP_FORMAT
      desc 'event name separator'
      config_param :event_name_separator, :string, default: DEFAULT_EVENT_NAME_SEPARATOR

      desc 'collect cluster health events'
      config_param :cluster_health, :bool, default: DEFAULT_CLUSTER_HEALTH
      desc 'details level of the health information'
      config_param :cluster_health_level, :enum, list: ALLOWED_CLUSTER_HEALTH_LEVELS,
                                                 default: DEFAULT_CLUSTER_HEALTH_LEVEL
      desc 'retrieves information from the local node only'
      config_param :cluster_health_local, :bool, default: DEFAULT_CLUSTER_HEALTH_LOCAL

      desc 'collect cluster stats events'
      config_param :cluster_stats, :bool, default: DEFAULT_CLUSTER_STATS

      desc 'collect nodes stats events'
      config_param :nodes_stats, :bool, default: DEFAULT_NODES_STATS
      desc 'details level for the nodes stats'
      config_param :nodes_stats_level, :enum, list: ALLOWED_NODES_STATS_LEVELS, default: DEFAULT_NODES_STATS_LEVEL
      desc 'limits information to specific metrics for nodes stats'
      config_param :nodes_stats_metrics, :array, value_type: :string, default: DEFAULT_NODES_STATS_METRICS

      desc 'enable indices_stats collect'
      config_param :indices_stats, :bool, default: DEFAULT_INDICES_STATS
      desc 'indices_stats indices to collect'
      config_param :indices, :array, value_type: :string, default: DEFAULT_INDICES
      desc 'indices_stats details level'
      config_param :indices_stats_level, :enum, list: ALLOWED_INDICES_STATS_LEVELS, default: DEFAULT_INDICES_STATS_LEVEL

      desc 'collect dangling events'
      config_param :dangling, :bool, default: DEFAULT_DANGLING

      desc 'base index pattern to generate aggregated index metrics'
      config_param :index_base_pattern, :regexp, default: DEFAULT_INDEX_BASE_PATTERN
      desc 'base index pattern replacement to generate aggregated index metrics'
      config_param :index_base_replacement, :string, default: DEFAULT_INDEX_BASE_REPLACEMENT

      # desc 'skip system indices'
      # config_param :skip_system_indices, :bool, default: DEFAULT_SKIP_SYSTEM_INDICES

      def configure(conf)
        super

        raise Fluent::ConfigError, 'tag should not be empty' if tag.empty?
        raise Fluent::ConfigError, 'urls should not be empty' if urls.empty?

        @mutex_emit = Mutex.new

        ElasticsearchStats::Metadata.metadata_prefix = metadata_prefix
        ElasticsearchStats::Metric.metric_prefix = metric_prefix
        ElasticsearchStats::Metric.timestamp_format = timestamp_format
        ElasticsearchStats::Metric.index_base_pattern = index_base_pattern
        ElasticsearchStats::Metric.index_base_replacement = index_base_replacement
        ElasticsearchStats::Metric.name_separator = event_name_separator

        configure_elasticsearchs
      end

      def configure_elasticsearchs
        @elasticsearchs = []
        urls.each do |url|
          client = ElasticsearchStats::Client.new(
            url: url, timeout: timeout, username: username, password: password,
            user_agent: user_agent, ca_file: ca_file, verify_ssl: verify_ssl,
            log: log
          )
          @elasticsearchs << ElasticsearchStats::Collector.new(
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
          router.emit_stream(tag, events)
        end
      end
    end
  end
end
