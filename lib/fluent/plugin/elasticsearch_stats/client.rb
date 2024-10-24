# frozen_string_literal: true

require 'faraday'

module Fluent
  module Plugin
    module ElasticsearchStats
      class Client
        class Error < StandardError
        end

        TIMEOUT = 10
        USER_AGENT = 'elasticsearch_stats'

        LOCAL = false
        CLUSTER_HEALTH_LEVEL = 'cluster'
        NODES_STATS_LEVEL = 'cluster'
        INDICES_STATS_LEVEL = 'indices'
        INDICES = [:_all]

        ALLOWED_CLUSTER_HEALTH_LEVELS = %i[cluster indices shards].freeze
        ALLOWED_NODES_STATS_LEVELS = %i[nodes indices shards].freeze
        ALLOWED_NODES_STATS_METRICS = %i[
          adaptive_selection
          breaker
          discovery
          fs
          http
          indexing_pressure
          indices
          ingest
          jvm
          os
          process
          repositories
          thread_pool
          transport
        ].freeze
        ALLOWED_INDICES_LEVELS = %i[cluster indices shards].freeze
        ALLOWED_INDICES_METRICS = %i[
          _all
          completion
          docs
          fielddata
          flush
          get
          indexing
          merge
          query_cache
          refresh
          request_cache
          search
          segments
          store
          translog
        ].freeze

        attr_reader :url, :timeout, :username, :password, :user_agent,
                    :ca_file, :verify_ssl, :log, :client

        def initialize(url:, timeout: TIMEOUT, username: nil, password: nil,
                       user_agent: USER_AGENT, ca_file: nil, verify_ssl: true,
                       log: nil)
          @url = url
          @timeout = timeout
          @username = username
          @password = password
          @user_agent = user_agent
          @ca_file = ca_file
          @verify_ssl = verify_ssl
          @log = log
        end

        # https://www.elastic.co/guide/en/elasticsearch/reference/current/cluster-health.html
        def cluster_health(level: CLUSTER_HEALTH_LEVEL, local: LOCAL)
          endpoint = '/_cluster/health'
          params = { level: level, local: local, timeout: "#{timeout}s" }
          get(endpoint, params)
        end

        # https://www.elastic.co/guide/en/elasticsearch/reference/current/cluster-stats.html
        def cluster_stats
          endpoint = '/_cluster/stats'
          params = { timeout: "#{timeout}s" }
          get(endpoint, params)
        end

        # https://www.elastic.co/guide/en/elasticsearch/reference/current/cluster-nodes-stats.html
        def nodes_stats(level: NODES_STATS_LEVEL, metrics: nil)
          endpoint = '/_nodes/stats'
          endpoint += "/#{metrics.join(',')}" if metrics&.any?
          params = { level: level, timeout: "#{timeout}s" }
          get(endpoint, params)
        end

        # https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-stats.html
        def indices_stats(indices: INDICES, level: INDICES_STATS_LEVEL, metrics: nil)
          indices ||= INDICES
          endpoint = "/_stats"
          endpoint = "/#{indices.join(',')}#{endpoint}" if !indices.nil? && !indices.empty?
          endpoint += "/#{metrics.join(',')}" if metrics&.any?
          params = { level: level }
          get(endpoint, params)
        end

        # https://www.elastic.co/guide/en/elasticsearch/reference/current/dangling-indices-list.html
        def dangling
          endpoint = '/_dangling'
          get(endpoint)
        end

        private

        def get(endpoint, params = nil, header = nil)
          response = conn.get(endpoint, params, header)
          response.body
        rescue Faraday::Error => e
          log.error("while get #{endpoint}: #{e}")
          raise Error, "error on get #{endpoint}", e
        end

        def conn
          faraday_options = {
            request: {
              open_timeout: timeout + 1,
              read_timeout: timeout + 1,
              write_timeout: timeout + 1
            },
            ssl: {
              verify: verify_ssl,
              ca_file: ca_file
            },
            headers: {
              'User-Agent' => user_agent
            }
          }

          @conn ||= Faraday.new(url: url, **faraday_options) do |config|
            config.request :authorization, :basic, username, password if username && password
            config.request :json
            config.response :json
            config.response :raise_error
            config.response :logger, log, headers: false, bodies: false, log_level: :debug if log
            config.adapter :net_http
          end
        end
      end
    end
  end
end
