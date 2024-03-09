# frozen_string_literal: true

module Fluent
  module Plugin
    module ElasticsearchStats
      class Metadata
        class << self
          attr_accessor :metadata_prefix
        end

        attr_reader :metadata, :metadata_prefix

        def initialize(metadata = {}, metadata_prefix: self.class.metadata_prefix)
          @metadata = {}.update(metadata)
          @metadata_prefix = metadata_prefix
        end

        def set(label:, value:)
          return self if label.nil? || label.to_s.empty?

          @metadata[label_for(label)] = value

          self
        end

        def get(label)
          metadata[label_for(label)]
        end

        def dup
          self.class.new(
            metadata.clone,
            metadata_prefix: metadata_prefix.clone
          )
        end

        def label_for(label)
          "#{metadata_prefix}#{label}"
        end

        def to_h
          metadata.clone
        end
      end
    end
  end
end
