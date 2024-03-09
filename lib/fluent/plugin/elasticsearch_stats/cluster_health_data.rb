# frozen_string_literal: true

require_relative 'base_data'

module Fluent
  module Plugin
    module ElasticsearchStats
      class ClusterHealthData < BaseData
        NAME = 'cluster_health'

        def extract_metrics
          extract_cluster_metrics + extract_indices_metrics
        end

        private

        def extract_cluster_metrics
          data.each_with_object([]) do |(k, v), metrics|
            metrics << metric.format(name: ['cluster', k], value: v, family: family, metadata: metadata)
          end.compact
        end
      end
    end
  end
end
