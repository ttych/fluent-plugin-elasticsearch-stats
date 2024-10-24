# frozen_string_literal: true

require_relative 'metadata'
require_relative 'metric'

module Fluent
  module Plugin
    module ElasticsearchStats
      class BaseData
        attr_reader :data

        # FIXME
        #   skip_system_indices
        def initialize(data, family: self.class::NAME, metadata: Metadata.new, metric: Metric.new)
          @data = data
          @family = family
          @metadata = metadata
          @metric = metric

          initialize_metadata
        end

        def extract_metrics
          []
        end

        private

        attr_reader :family, :metadata, :metric

        def initialize_metadata
          metadata.set(label: 'cluster_name', value: cluster_name) if cluster_name
        end

        def cluster_name
          data['cluster_name']
        end

        def extract_indices_metrics
          base_metrics = extract_indices_base_metrics
          aggregated_metrics = extract_indices_aggregated_metrics(base_metrics)

          return aggregated_metrics if metric.aggregated_index_metrics_only

          base_metrics + aggregated_metrics
        end

        def extract_indices_base_metrics
          return [] if !indices || indices.empty?

          metrics = []
          indices.each do |index_name, index_stats|
            local_metadata = metadata.dup.set(label: 'index', value: index_name)
            flattened_stats = Utils.hash_flatten_keys(index_stats, separator: metric.name_separator)
            flattened_stats.each do |k, v|
              metrics << metric.format(name: ['index', k], value: v, family: family, metadata: local_metadata)
            end
          end
          metrics.compact
        end

        def extract_indices_aggregated_metrics(base_metrics)
          metrics = []

          grouped_metrics = {}
          base_metrics.each do |base_metric|
            index_base = base_metric[metadata.label_for('index_base')]
            next unless index_base

            base_metric_name = base_metric[metric.name_label]
            grouped_metrics[index_base] ||= {}
            grouped_metrics[index_base][base_metric_name] ||= []
            grouped_metrics[index_base][base_metric_name] << base_metric
          end

          grouped_metrics.each do |index_base, index_base_metrics|
            local_metadata = metadata.dup
                                     .set(label: 'index', value: index_base)
                                     .set(label: 'aggregated', value: true)

            index_base_count = 0

            index_base_metrics.each do |metric_name, metric_name_metrics|
              metric_values = metric_name_metrics.map { |a_metric| a_metric[metric.value_label] }
              count = metric_values.size
              index_base_count = count if count > index_base_count

              if metric.aggregated_index_metrics.include?('count')
                metrics << metric.format(name: [metric_name, 'count'],
                                         value: count,
                                         family: family,
                                         metadata: local_metadata)
              end

              if metric.aggregated_index_metrics.include?('min')
                min = metric_values.min
                metrics << metric.format(name: [metric_name, 'min'],
                                         value: min,
                                         family: family,
                                         metadata: local_metadata)
              end

              if metric.aggregated_index_metrics.include?('max')
                max = metric_values.max
                metrics << metric.format(name: [metric_name, 'max'],
                                         value: max,
                                         family: family,
                                         metadata: local_metadata)
              end

              if metric.aggregated_index_metrics.include?('sum')
                sum = metric_values.sum
                metrics << metric.format(name: [metric_name, 'sum'],
                                         value: sum,
                                         family: family,
                                         metadata: local_metadata)
              end

              if metric.aggregated_index_metrics.include?('avg')
                avg = sum / count.to_f
                metrics << metric.format(name: [metric_name, 'avg'],
                                         value: avg,
                                         family: family,
                                         metadata: local_metadata)
              end
            end

            metrics << metric.format(name: %w[index count],
                                     value: index_base_count,
                                     family: family,
                                     metadata: local_metadata)
          end

          metrics.compact
        end

        def status
          data['status']
        end

        def indices
          data['indices']
        end
      end
    end
  end
end
