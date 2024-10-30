# frozen_string_literal: true

module Fluent
  module Plugin
    module ElasticsearchStats
      class Collector
        CLUSTER_INFO_TTL = 12 * 3600

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
          metrics += collect_nodes_stats_metrics
          metrics += collect_indices_stats_metrics
          metrics += collect_dangling_metrics
          metrics.compact
        end

        def collect_cluster_health_metrics
          return [] unless stats_config.cluster_health

          without_error(rescue_return: []) do
            data = client.cluster_health(
              level: stats_config.cluster_health_level,
              local: stats_config.cluster_health_local
            )
            ClusterHealthData.new(data, metadata: metadata).extract_metrics
          end
        end

        def collect_cluster_stats_metrics
          return [] unless stats_config.cluster_stats

          without_error(rescue_return: []) do
            data = client.cluster_stats
            ClusterStatsData.new(data, metadata: metadata).extract_metrics
          end
        end

        def collect_nodes_stats_metrics
          return [] unless stats_config.nodes_stats

          without_error(rescue_return: []) do
            data = client.nodes_stats(
              level: stats_config.nodes_stats_level,
              metrics: stats_config.nodes_stats_metrics
            )
            NodesStatsData.new(data, metadata: metadata).extract_metrics
          end
        end

        def collect_indices_stats_metrics
          return [] unless stats_config.indices_stats

          without_error(rescue_return: []) do
            data = client.indices_stats(
              indices: stats_config.indices,
              level: stats_config.indices_stats_level,
              metrics: stats_config.indices_stats_metrics
            )
            IndicesStatsData.new(data, metadata: metadata).extract_metrics
          end
        end

        def collect_dangling_metrics
          return [] unless stats_config.dangling

          without_error(rescue_return: []) do
            data = client.dangling
            DanglingData.new(data, metadata: metadata).extract_metrics
          end
        end

        def metadata
          Metadata.new
                  .set(label: 'cluster_name', value: cluster_info['cluster_name'])
          # .set(label: 'cluster_url', value: client.url)
        end

        def cluster_info(ttl: CLUSTER_INFO_TTL)
          cluster_info_prev = nil
          if @cluster_info_timestamp && (Time.now - @cluster_info_timestamp > ttl)
            cluster_info_prev = @cluster_info
            @cluster_info = nil
          end

          without_error do
            @cluster_info ||= client.cluster_info
            @cluster_info_timestamp = Time.now
          end
          @cluster_info ||= cluster_info_prev
        end

        def without_error(error: StandardError, rescue_return: nil)
          yield
        rescue error => e
          log.error("while collecting metrics: #{e}")
          rescue_return
        end
      end
    end
  end
end
