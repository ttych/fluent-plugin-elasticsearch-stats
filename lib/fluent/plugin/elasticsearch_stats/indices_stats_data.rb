# frozen_string_literal: true

require_relative 'base_data'

module Fluent
  module Plugin
    module ElasticsearchStats
      class IndicesStatsData < BaseData
        NAME = 'indices_stats'

        def extract_metrics
          extract_all_metrics + extract_indices_metrics
        end

        def extract_all_metrics
          return [] if !_all || _all.empty?

          metrics = []
          flattened = Utils.hash_flatten_keys(_all, separator: metric.name_separator)
          flattened.each do |k, v|
            metrics << metric.format(name: ['all_indices', k], value: v, family: family, metadata: metadata)
          end
          metrics.compact
        end

        private

        def _all
          data['_all']
        end
      end
    end
  end
end
