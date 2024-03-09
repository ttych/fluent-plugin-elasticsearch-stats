# frozen_string_literal: true

require 'json'

module Test
  module Fixture
    FIXTURE_PATH = File.expand_path(File.join(__dir__, 'fixtures'))

    def fixture_data(file_name)
      File.read(File.join(FIXTURE_PATH, file_name))
    end

    def fixture_json(file_name)
      file_name += '.json' if File.extname(file_name) != 'json'
      JSON.parse(fixture_data(file_name))
    end
  end
end
