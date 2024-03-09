# frozen_string_literal: true

module Fluent
  module Plugin
    module ElasticsearchStats
      class Metric
        DEFAULT_NAME_SEPARATOR = '/'
        DEFAULT_TIMESTAMP_FORMAT = :iso

        class << self
          attr_accessor :metric_prefix, :index_base_pattern, :index_base_replacement

          def name_separator
            @name_separator ||= DEFAULT_NAME_SEPARATOR
          end

          attr_writer :name_separator, :timestamp_format

          def timestamp_format
            @timestamp_format ||= DEFAULT_TIMESTAMP_FORMAT
          end
        end

        attr_reader :metric_prefix, :timestamp_format, :index_base_pattern, :index_base_replacement, :name_separator

        def initialize(metric_prefix: nil, timestamp_format: nil, index_base_pattern: nil, index_base_replacement: nil,
                       name_separator: nil)
          @metric_prefix = metric_prefix || self.class.metric_prefix
          @timestamp_format = timestamp_format || self.class.timestamp_format
          @index_base_pattern = index_base_pattern || self.class.index_base_pattern
          @index_base_replacement = index_base_replacement || self.class.index_base_replacement
          @name_separator = name_separator || self.class.name_separator
        end

        def convert_status(status)
          case status.downcase
          when 'green' then 1
          when 'yellow' then 2
          when 'red' then 3
          else 0
          end
        end

        def timenow_epochmillis
          (Time.now.utc.to_f * 1000).to_i
        end

        def timenow_iso
          Time.now.utc.iso8601(3)
        end

        def timenow
          send("timenow_#{timestamp_format}")
        end

        def format(name:, value:, family: nil, metadata: nil)
          return if name.nil? || name.empty? || value.nil?

          value = convert_status(value) if name == 'status' || name[-1] == 'status'
          name = name.join(name_separator) if name.respond_to?(:join)
          family = family.join(name_separator) if name.respond_to?(:join)

          return unless value.is_a?(Numeric)

          index_base = compute_index_base(metadata.get('index'))
          local_metadata = metadata.dup
          local_metadata.set(label: 'index_base', value: index_base) if index_base

          metric = {}
          metric.update(local_metadata.to_h)
          metric['timestamp'] = timenow
          metric[name_label] = name.to_s
          metric[value_label] = value
          metric[family_label] = family.to_s if family
          metric
        end

        def name_label
          "#{metric_prefix}name"
        end

        def value_label
          "#{metric_prefix}value"
        end

        def family_label
          "#{metric_prefix}family"
        end

        def compute_index_base(index_name)
          return nil unless index_name
          return nil if !index_base_pattern || !index_base_replacement

          index_name.gsub(index_base_pattern, index_base_replacement)
        rescue StandardError
          nil
        end
      end
    end
  end
end
