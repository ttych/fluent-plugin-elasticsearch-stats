# frozen_string_literal: true

require_relative 'base_data'

module Fluent
  module Plugin
    module ElasticsearchStats
      class DanglingData < BaseData
        NAME = 'dangling'

        def extract_metrics
          generate_dangling_indices_count
        end

        def generate_dangling_indices_count
          metrics = []
          metrics << metric.format(name: %w[dangling all count],
                                   value: dangling_indices.size,
                                   family: family,
                                   metadata: metadata)
          metrics
        end

        private

        def dangling_indices
          data.fetch('dangling_indices', [])
        end
      end
    end
  end
end
