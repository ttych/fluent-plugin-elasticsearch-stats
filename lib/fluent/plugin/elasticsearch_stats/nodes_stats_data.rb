# frozen_string_literal: true

require_relative 'base_data'

module Fluent
  module Plugin
    module ElasticsearchStats
      class NodesStatsData < BaseData
        NAME = 'nodes_stats'

        def extract_metrics
          metrics = []
          nodes.each_value do |node_stats|
            metadata.dup
                    .set(label: 'hostname', value: node_stats['name'])
                    .set(label: 'host', value: node_stats['host'])

            node_stats.each do |stat_family, stats|
              next unless stats.is_a?(Hash)

              stats.delete('timestamp')
              stats.delete('indices') if stat_family == 'indices'
              # FIXME: indices stats to extract ?

              flattened_stats = Utils.hash_flatten_keys(stats, separator: metric.name_separator)
              flattened_stats.each do |k, v|
                metrics << metric.format(name: ['node', stat_family, k], value: v, family: family, metadata: metadata)
              end
            end
          end
          metrics.compact
        end

        private

        def nodes
          data['nodes']
        end
      end
    end
  end
end
