# frozen_string_literal: true

module Fluent
  module Plugin
    class ElasticsearchStats
      attr_reader :client, :stats_config, :log

      def initialize(client:,
                     stats_config: {},
                     log: nil)
        @client = client
        @stats_config = stats_config
        @log = log
      end

      def collect_stats_metrics
        metrics = []
        metrics += collect_cluster_health_metrics
        metrics += collect_cluster_stats_metrics
        metrics += collect_node_stats_metrics
        metrics += collect_indices_stats_metrics
        metrics += collect_shards_stats_metrics
        metrics += collect_dangling_metrics
      end

      def collect_cluster_health_metrics
        []
      end

      def collect_cluster_stats_metrics
        []
      end

      def collect_node_stats_metrics
        []
      end

      def collect_indices_stats_metrics
        []
      end

      def collect_shards_stats_metrics
        []
      end

      def collect_dangling_metrics
        []
      end
    end

    class ElasticsearchStatsClient
      TIMEOUT = 10
      USER_AGENT = 'elasticsearch_stats'

      attr_reader :url, :timeout, :username, :password, :user_agent,
                  :ca_file, :verify_ssl, :log

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
    end
  end
end
