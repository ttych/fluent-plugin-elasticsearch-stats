# frozen_string_literal: true

require 'helper'
require 'fluent/plugin/elasticsearch_stats/cluster_health_data'

class DanglingDataTest < Test::Unit::TestCase
  TEST_TIME = DateTime.parse('2024-01-01').to_time.utc
  TEST_TIME_ISO = TEST_TIME.iso8601(3)
  TEST_TIME_EPOCHMILLIS = (TEST_TIME.to_f * 1000).to_i

  setup do
    Timecop.freeze(TEST_TIME)
  end

  teardown do
    Timecop.return
  end

  def create_data(data: nil, family: nil, metadata: nil, metric: nil)
    params = {}
    params[:family] = family if family
    params[:metadata] = metadata if metadata
    params[:metric] = metric if metric
    Fluent::Plugin::ElasticsearchStats::DanglingData.new(
      data,
      **params
    )
  end

  sub_test_case 'dangling_count metrics' do
    test 'it has dangling_count metric' do
      data = create_data(data: fixture_json('dangling'))
      expected_metric = { 'timestamp' => TEST_TIME_ISO,
                          'name' => 'dangling/all/count',
                          'value' => 1,
                          'family' => 'dangling' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end
end
