# frozen_string_literal: true

require 'helper'
require 'fluent/plugin/in_elasticsearch_stats'

class ElasticsearchStatsInputTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test 'true' do
    true
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Input.new(Fluent::Plugin::ElasticsearchStatsInput).configure(conf)
  end
end
