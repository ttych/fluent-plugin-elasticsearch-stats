# frozen_string_literal: true

module Fluent
  module Plugin
    module ElasticsearchStats
      module Utils
        def self.hash_flatten_keys(hash, overwite: false, separator: nil)
          return nil unless hash.is_a?(Hash)

          flattened = {}
          stack = [hash.each]
          keys = []

          while stack.any?
            current = stack.pop

            begin
              child_k, child_v = current.next
              stack.push current

              if child_v.is_a?(Hash)
                stack.push child_v.each
                keys.push child_k
              else
                flattened_key = keys + [child_k]
                flattened_key = flattened_key.join(separator) if separator
                raise KeyError, "key #{flattened_key} already present" if !overwite && flattened.key?(flattened_key)

                flattened[flattened_key] = child_v
              end
            rescue StopIteration
              keys.pop
              next
            end
          end

          flattened
        end
      end
    end
  end
end
