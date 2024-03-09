# frozen_string_literal: true

require_relative 'base_data'

module Fluent
  module Plugin
    module ElasticsearchStats
      class ClusterStatsData < BaseData
        NAME = 'cluster_stats'

        def extract_metrics
          extract_base_metrics + extract_indices_metrics + extract_nodes_metrics
        end

        private

        def extract_base_metrics
          status_metric = metric.format(
            name: %w[cluster status], value: status, family: family, metadata: metadata
          )
          [status_metric]
        end

        def extract_indices_metrics
          metrics = []

          flattened_data = Utils.hash_flatten_keys(indices, separator: metric.name_separator)
          flattened_data.each do |k, v|
            metrics << metric.format(name: ['indices', k], value: v, family: family, metadata: metadata)
          end
          metrics.compact
        end

        def extract_nodes_metrics
          metrics = []
          flattened_data = Utils.hash_flatten_keys(nodes, separator: metric.name_separator)
          flattened_data.each do |k, v|
            metrics << metric.format(name: ['nodes', k], value: v, family: family, metadata: metadata)
          end
          metrics.compact
        end

        def nodes
          data['nodes']
        end
      end
    end
  end
end
