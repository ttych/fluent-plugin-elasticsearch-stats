# frozen_string_literal: true

require 'helper'
require 'fluent/plugin/elasticsearch_stats/cluster_health_data'

class IndicesStatsDataTest < Test::Unit::TestCase
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
    Fluent::Plugin::ElasticsearchStats::IndicesStatsData.new(
      data,
      **params
    )
  end

  def create_metric(**options)
    Fluent::Plugin::ElasticsearchStats::Metric.new(
      **options
    )
  end

  def create_full_agr_metric(**options)
    options[:aggregated_index_metrics] = ['avg', 'count', 'min', 'max', 'sum']
    create_metric(**options)
  end

  sub_test_case '_all metrics' do
    test 'it has all_indices/primaries/docs/count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/docs/count", "value"=>39, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/docs/deleted metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/docs/deleted", "value"=>39, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/shard_stats/total_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/shard_stats/total_count", "value"=>3, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/store/size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/store/size_in_bytes", "value"=>38891981, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/store/total_data_set_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/store/total_data_set_size_in_bytes", "value"=>38891981, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/store/reserved_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/store/reserved_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/indexing/index_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/indexing/index_total", "value"=>2, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/indexing/index_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/indexing/index_time_in_millis", "value"=>3, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/indexing/index_current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/indexing/index_current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/indexing/index_failed metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/indexing/index_failed", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/indexing/delete_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/indexing/delete_total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/indexing/delete_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/indexing/delete_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/indexing/delete_current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/indexing/delete_current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/indexing/noop_update_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/indexing/noop_update_total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/indexing/throttle_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/indexing/throttle_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/get/total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/get/total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/get/time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/get/time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/get/exists_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/get/exists_total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/get/exists_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/get/exists_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/get/missing_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/get/missing_total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/get/missing_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/get/missing_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/get/current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/get/current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/open_contexts metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/open_contexts", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/query_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/query_total", "value"=>39, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/query_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/query_time_in_millis", "value"=>61, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/query_current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/query_current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/fetch_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/fetch_total", "value"=>39, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/fetch_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/fetch_time_in_millis", "value"=>339, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/fetch_current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/fetch_current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/scroll_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/scroll_total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/scroll_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/scroll_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/scroll_current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/scroll_current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/suggest_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/suggest_total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/suggest_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/suggest_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/search/suggest_current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/search/suggest_current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/merges/current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/merges/current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/merges/current_docs metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/merges/current_docs", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/merges/current_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/merges/current_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/merges/total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/merges/total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/merges/total_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/merges/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/merges/total_docs metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/merges/total_docs", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/merges/total_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/merges/total_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/merges/total_stopped_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/merges/total_stopped_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/merges/total_throttled_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/merges/total_throttled_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/merges/total_auto_throttle_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/merges/total_auto_throttle_in_bytes", "value"=>62914560, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/refresh/total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/refresh/total", "value"=>6, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/refresh/total_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/refresh/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/refresh/external_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/refresh/external_total", "value"=>6, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/refresh/external_total_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/refresh/external_total_time_in_millis", "value"=>2, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/refresh/listeners metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/refresh/listeners", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/flush/total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/flush/total", "value"=>1, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/flush/periodic metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/flush/periodic", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/flush/total_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/flush/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/warmer/current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/warmer/current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/warmer/total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/warmer/total", "value"=>3, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/warmer/total_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/warmer/total_time_in_millis", "value"=>1, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/query_cache/memory_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/query_cache/memory_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/query_cache/total_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/query_cache/total_count", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/query_cache/hit_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/query_cache/hit_count", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/query_cache/miss_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/query_cache/miss_count", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/query_cache/cache_size metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/query_cache/cache_size", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/query_cache/cache_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/query_cache/cache_count", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/query_cache/evictions metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/query_cache/evictions", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/fielddata/memory_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/fielddata/memory_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/fielddata/evictions metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/fielddata/evictions", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/completion/size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/completion/size_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/segments/count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/segments/count", "value"=>1, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/segments/memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/segments/memory_in_bytes", "value"=>1436, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/segments/terms_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/segments/terms_memory_in_bytes", "value"=>512, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/segments/stored_fields_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/segments/stored_fields_memory_in_bytes", "value"=>520, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/segments/term_vectors_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/segments/term_vectors_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/segments/norms_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/segments/norms_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/segments/points_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/segments/points_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/segments/doc_values_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/segments/doc_values_memory_in_bytes", "value"=>404, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/segments/index_writer_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/segments/index_writer_memory_in_bytes", "value"=>263352, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/segments/version_map_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/segments/version_map_memory_in_bytes", "value"=>234, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/segments/fixed_bit_set_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/segments/fixed_bit_set_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/segments/max_unsafe_auto_id_timestamp metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/segments/max_unsafe_auto_id_timestamp", "value"=>-1, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/translog/operations metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/translog/operations", "value"=>2, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/translog/size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/translog/size_in_bytes", "value"=>385, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/translog/uncommitted_operations metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/translog/uncommitted_operations", "value"=>2, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/translog/uncommitted_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/translog/uncommitted_size_in_bytes", "value"=>385, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/translog/earliest_last_modified_age metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/translog/earliest_last_modified_age", "value"=>78079, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/request_cache/memory_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/request_cache/memory_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/request_cache/evictions metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/request_cache/evictions", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/request_cache/hit_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/request_cache/hit_count", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/request_cache/miss_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/request_cache/miss_count", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/recovery/current_as_source metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/recovery/current_as_source", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/recovery/current_as_target metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/recovery/current_as_target", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/primaries/recovery/throttle_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/primaries/recovery/throttle_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/docs/count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/docs/count", "value"=>39, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/docs/deleted metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/docs/deleted", "value"=>39, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/shard_stats/total_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/shard_stats/total_count", "value"=>3, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/store/size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/store/size_in_bytes", "value"=>38891981, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/store/total_data_set_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/store/total_data_set_size_in_bytes", "value"=>38891981, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/store/reserved_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/store/reserved_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/indexing/index_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/indexing/index_total", "value"=>2, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/indexing/index_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/indexing/index_time_in_millis", "value"=>3, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/indexing/index_current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/indexing/index_current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/indexing/index_failed metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/indexing/index_failed", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/indexing/delete_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/indexing/delete_total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/indexing/delete_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/indexing/delete_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/indexing/delete_current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/indexing/delete_current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/indexing/noop_update_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/indexing/noop_update_total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/indexing/throttle_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/indexing/throttle_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/get/total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/get/total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/get/time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/get/time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/get/exists_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/get/exists_total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/get/exists_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/get/exists_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/get/missing_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/get/missing_total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/get/missing_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/get/missing_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/get/current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/get/current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/open_contexts metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/open_contexts", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/query_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/query_total", "value"=>39, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/query_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/query_time_in_millis", "value"=>61, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/query_current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/query_current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/fetch_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/fetch_total", "value"=>39, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/fetch_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/fetch_time_in_millis", "value"=>339, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/fetch_current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/fetch_current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/scroll_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/scroll_total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/scroll_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/scroll_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/scroll_current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/scroll_current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/suggest_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/suggest_total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/suggest_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/suggest_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/search/suggest_current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/search/suggest_current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/merges/current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/merges/current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/merges/current_docs metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/merges/current_docs", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/merges/current_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/merges/current_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/merges/total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/merges/total", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/merges/total_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/merges/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/merges/total_docs metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/merges/total_docs", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/merges/total_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/merges/total_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/merges/total_stopped_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/merges/total_stopped_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/merges/total_throttled_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/merges/total_throttled_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/merges/total_auto_throttle_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/merges/total_auto_throttle_in_bytes", "value"=>62914560, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/refresh/total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/refresh/total", "value"=>6, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/refresh/total_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/refresh/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/refresh/external_total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/refresh/external_total", "value"=>6, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/refresh/external_total_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/refresh/external_total_time_in_millis", "value"=>2, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/refresh/listeners metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/refresh/listeners", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/flush/total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/flush/total", "value"=>1, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/flush/periodic metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/flush/periodic", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/flush/total_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/flush/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/warmer/current metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/warmer/current", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/warmer/total metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/warmer/total", "value"=>3, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/warmer/total_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/warmer/total_time_in_millis", "value"=>1, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/query_cache/memory_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/query_cache/memory_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/query_cache/total_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/query_cache/total_count", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/query_cache/hit_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/query_cache/hit_count", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/query_cache/miss_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/query_cache/miss_count", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/query_cache/cache_size metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/query_cache/cache_size", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/query_cache/cache_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/query_cache/cache_count", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/query_cache/evictions metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/query_cache/evictions", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/fielddata/memory_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/fielddata/memory_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/fielddata/evictions metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/fielddata/evictions", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/completion/size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/completion/size_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/segments/count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/segments/count", "value"=>1, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/segments/memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/segments/memory_in_bytes", "value"=>1436, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/segments/terms_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/segments/terms_memory_in_bytes", "value"=>512, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/segments/stored_fields_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/segments/stored_fields_memory_in_bytes", "value"=>520, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/segments/term_vectors_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/segments/term_vectors_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/segments/norms_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/segments/norms_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/segments/points_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/segments/points_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/segments/doc_values_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/segments/doc_values_memory_in_bytes", "value"=>404, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/segments/index_writer_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/segments/index_writer_memory_in_bytes", "value"=>263352, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/segments/version_map_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/segments/version_map_memory_in_bytes", "value"=>234, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/segments/fixed_bit_set_memory_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/segments/fixed_bit_set_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/segments/max_unsafe_auto_id_timestamp metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/segments/max_unsafe_auto_id_timestamp", "value"=>-1, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/translog/operations metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/translog/operations", "value"=>2, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/translog/size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/translog/size_in_bytes", "value"=>385, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/translog/uncommitted_operations metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/translog/uncommitted_operations", "value"=>2, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/translog/uncommitted_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/translog/uncommitted_size_in_bytes", "value"=>385, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/translog/earliest_last_modified_age metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/translog/earliest_last_modified_age", "value"=>78079, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/request_cache/memory_size_in_bytes metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/request_cache/memory_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/request_cache/evictions metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/request_cache/evictions", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/request_cache/hit_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/request_cache/hit_count", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/request_cache/miss_count metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/request_cache/miss_count", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/recovery/current_as_source metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/recovery/current_as_source", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/recovery/current_as_target metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/recovery/current_as_target", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has all_indices/total/recovery/throttle_time_in_millis metric' do
      data = create_data(data: fixture_json('indices_stats__indices'))
      expected_metric = {"timestamp"=>TEST_TIME_ISO, "name"=>"all_indices/total/recovery/throttle_time_in_millis", "value"=>0, "family"=>"indices_stats"}
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'indices metrics' do
    sub_test_case 'non aggregated indices' do
      test 'it has index/primaries/docs/count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/docs/count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/docs/deleted metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/docs/deleted", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/shard_stats/total_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/shard_stats/total_count", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/store/size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/store/size_in_bytes", "value"=>226, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/store/total_data_set_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/store/total_data_set_size_in_bytes", "value"=>226, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/store/reserved_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/store/reserved_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/indexing/index_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/indexing/index_total", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/indexing/index_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/indexing/index_time_in_millis", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/indexing/index_current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/indexing/index_current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/indexing/index_failed metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/indexing/index_failed", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/indexing/delete_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/indexing/delete_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/indexing/delete_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/indexing/delete_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/indexing/delete_current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/indexing/delete_current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/indexing/noop_update_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/indexing/noop_update_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/indexing/throttle_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/indexing/throttle_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/get/total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/get/total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/get/time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/get/time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/get/exists_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/get/exists_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/get/exists_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/get/exists_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/get/missing_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/get/missing_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/get/missing_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/get/missing_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/get/current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/get/current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/open_contexts metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/open_contexts", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/query_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/query_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/query_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/query_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/query_current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/query_current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/fetch_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/fetch_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/fetch_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/fetch_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/fetch_current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/fetch_current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/scroll_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/scroll_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/scroll_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/scroll_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/scroll_current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/scroll_current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/suggest_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/suggest_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/suggest_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/suggest_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/search/suggest_current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/search/suggest_current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/merges/current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/merges/current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/merges/current_docs metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/merges/current_docs", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/merges/current_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/merges/current_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/merges/total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/merges/total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/merges/total_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/merges/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/merges/total_docs metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/merges/total_docs", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/merges/total_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/merges/total_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/merges/total_stopped_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/merges/total_stopped_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/merges/total_throttled_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/merges/total_throttled_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/merges/total_auto_throttle_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/merges/total_auto_throttle_in_bytes", "value"=>20971520, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/refresh/total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/refresh/total", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/refresh/total_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/refresh/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/refresh/external_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/refresh/external_total", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/refresh/external_total_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/refresh/external_total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/refresh/listeners metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/refresh/listeners", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/flush/total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/flush/total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/flush/periodic metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/flush/periodic", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/flush/total_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/flush/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/warmer/current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/warmer/current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/warmer/total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/warmer/total", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/warmer/total_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/warmer/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/query_cache/memory_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/query_cache/memory_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/query_cache/total_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/query_cache/total_count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/query_cache/hit_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/query_cache/hit_count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/query_cache/miss_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/query_cache/miss_count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/query_cache/cache_size metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/query_cache/cache_size", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/query_cache/cache_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/query_cache/cache_count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/query_cache/evictions metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/query_cache/evictions", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/fielddata/memory_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/fielddata/memory_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/fielddata/evictions metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/fielddata/evictions", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/completion/size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/completion/size_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/segments/count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/segments/count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/segments/memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/segments/memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/segments/terms_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/segments/terms_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/segments/stored_fields_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/segments/stored_fields_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/segments/term_vectors_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/segments/term_vectors_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/segments/norms_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/segments/norms_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/segments/points_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/segments/points_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/segments/doc_values_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/segments/doc_values_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/segments/index_writer_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/segments/index_writer_memory_in_bytes", "value"=>131676, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/segments/version_map_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/segments/version_map_memory_in_bytes", "value"=>117, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/segments/fixed_bit_set_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/segments/fixed_bit_set_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/segments/max_unsafe_auto_id_timestamp metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/segments/max_unsafe_auto_id_timestamp", "value"=>-1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/translog/operations metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/translog/operations", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/translog/size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/translog/size_in_bytes", "value"=>165, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/translog/uncommitted_operations metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/translog/uncommitted_operations", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/translog/uncommitted_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/translog/uncommitted_size_in_bytes", "value"=>165, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/translog/earliest_last_modified_age metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/translog/earliest_last_modified_age", "value"=>86292, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/request_cache/memory_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/request_cache/memory_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/request_cache/evictions metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/request_cache/evictions", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/request_cache/hit_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/request_cache/hit_count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/request_cache/miss_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/request_cache/miss_count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/recovery/current_as_source metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/recovery/current_as_source", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/recovery/current_as_target metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/recovery/current_as_target", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/primaries/recovery/throttle_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/primaries/recovery/throttle_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/docs/count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/docs/count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/docs/deleted metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/docs/deleted", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/shard_stats/total_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/shard_stats/total_count", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/store/size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/store/size_in_bytes", "value"=>226, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/store/total_data_set_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/store/total_data_set_size_in_bytes", "value"=>226, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/store/reserved_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/store/reserved_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/indexing/index_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/indexing/index_total", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/indexing/index_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/indexing/index_time_in_millis", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/indexing/index_current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/indexing/index_current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/indexing/index_failed metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/indexing/index_failed", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/indexing/delete_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/indexing/delete_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/indexing/delete_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/indexing/delete_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/indexing/delete_current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/indexing/delete_current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/indexing/noop_update_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/indexing/noop_update_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/indexing/throttle_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/indexing/throttle_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/get/total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/get/total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/get/time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/get/time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/get/exists_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/get/exists_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/get/exists_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/get/exists_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/get/missing_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/get/missing_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/get/missing_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/get/missing_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/get/current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/get/current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/open_contexts metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/open_contexts", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/query_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/query_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/query_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/query_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/query_current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/query_current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/fetch_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/fetch_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/fetch_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/fetch_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/fetch_current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/fetch_current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/scroll_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/scroll_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/scroll_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/scroll_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/scroll_current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/scroll_current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/suggest_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/suggest_total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/suggest_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/suggest_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/search/suggest_current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/search/suggest_current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/merges/current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/merges/current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/merges/current_docs metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/merges/current_docs", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/merges/current_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/merges/current_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/merges/total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/merges/total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/merges/total_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/merges/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/merges/total_docs metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/merges/total_docs", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/merges/total_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/merges/total_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/merges/total_stopped_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/merges/total_stopped_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/merges/total_throttled_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/merges/total_throttled_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/merges/total_auto_throttle_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/merges/total_auto_throttle_in_bytes", "value"=>20971520, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/refresh/total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/refresh/total", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/refresh/total_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/refresh/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/refresh/external_total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/refresh/external_total", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/refresh/external_total_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/refresh/external_total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/refresh/listeners metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/refresh/listeners", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/flush/total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/flush/total", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/flush/periodic metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/flush/periodic", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/flush/total_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/flush/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/warmer/current metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/warmer/current", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/warmer/total metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/warmer/total", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/warmer/total_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/warmer/total_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/query_cache/memory_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/query_cache/memory_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/query_cache/total_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/query_cache/total_count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/query_cache/hit_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/query_cache/hit_count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/query_cache/miss_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/query_cache/miss_count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/query_cache/cache_size metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/query_cache/cache_size", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/query_cache/cache_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/query_cache/cache_count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/query_cache/evictions metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/query_cache/evictions", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/fielddata/memory_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/fielddata/memory_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/fielddata/evictions metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/fielddata/evictions", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/completion/size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/completion/size_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/segments/count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/segments/count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/segments/memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/segments/memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/segments/terms_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/segments/terms_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/segments/stored_fields_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/segments/stored_fields_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/segments/term_vectors_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/segments/term_vectors_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/segments/norms_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/segments/norms_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/segments/points_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/segments/points_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/segments/doc_values_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/segments/doc_values_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/segments/index_writer_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/segments/index_writer_memory_in_bytes", "value"=>131676, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/segments/version_map_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/segments/version_map_memory_in_bytes", "value"=>117, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/segments/fixed_bit_set_memory_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/segments/fixed_bit_set_memory_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/segments/max_unsafe_auto_id_timestamp metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/segments/max_unsafe_auto_id_timestamp", "value"=>-1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/translog/operations metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/translog/operations", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/translog/size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/translog/size_in_bytes", "value"=>165, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/translog/uncommitted_operations metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/translog/uncommitted_operations", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/translog/uncommitted_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/translog/uncommitted_size_in_bytes", "value"=>165, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/translog/earliest_last_modified_age metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/translog/earliest_last_modified_age", "value"=>86292, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/request_cache/memory_size_in_bytes metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/request_cache/memory_size_in_bytes", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/request_cache/evictions metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/request_cache/evictions", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/request_cache/hit_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/request_cache/hit_count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/request_cache/miss_count metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/request_cache/miss_count", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/recovery/current_as_source metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/recovery/current_as_source", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/recovery/current_as_target metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/recovery/current_as_target", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has index/total/recovery/throttle_time_in_millis metric' do
        data = create_data(data: fixture_json('indices_stats__indices'))
        expected_metric = {"index"=>"log-000001", "timestamp"=>TEST_TIME_ISO, "name"=>"index/total/recovery/throttle_time_in_millis", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end
    end

    sub_test_case 'full aggregated indices' do
      test 'it has indices/primaries/docs/count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/docs/count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/docs/count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/docs/count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/docs/count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/docs/count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/docs/count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/docs/count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/docs/count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/docs/count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/docs/deleted/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/docs/deleted/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/docs/deleted/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/docs/deleted/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/docs/deleted/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/docs/deleted/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/docs/deleted/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/docs/deleted/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/docs/deleted/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/docs/deleted/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/shard_stats/total_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/shard_stats/total_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/shard_stats/total_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/shard_stats/total_count/min", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/shard_stats/total_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/shard_stats/total_count/max", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/shard_stats/total_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/shard_stats/total_count/sum", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/shard_stats/total_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/shard_stats/total_count/avg", "value"=>1.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/size_in_bytes/min", "value"=>226, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/size_in_bytes/max", "value"=>226, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/size_in_bytes/sum", "value"=>452, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/size_in_bytes/avg", "value"=>226.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/total_data_set_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/total_data_set_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/total_data_set_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/total_data_set_size_in_bytes/min", "value"=>226, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/total_data_set_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/total_data_set_size_in_bytes/max", "value"=>226, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/total_data_set_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/total_data_set_size_in_bytes/sum", "value"=>452, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/total_data_set_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/total_data_set_size_in_bytes/avg", "value"=>226.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/reserved_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/reserved_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/reserved_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/reserved_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/reserved_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/reserved_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/reserved_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/reserved_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/store/reserved_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/store/reserved_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_total/min", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_total/max", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_total/sum", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_total/avg", "value"=>1.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_time_in_millis/min", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_time_in_millis/max", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_time_in_millis/sum", "value"=>3, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_time_in_millis/avg", "value"=>1.5, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_failed/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_failed/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_failed/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_failed/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_failed/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_failed/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_failed/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_failed/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/index_failed/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/index_failed/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/delete_current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/delete_current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/noop_update_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/noop_update_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/noop_update_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/noop_update_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/noop_update_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/noop_update_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/noop_update_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/noop_update_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/noop_update_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/noop_update_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/throttle_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/throttle_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/throttle_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/throttle_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/throttle_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/throttle_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/throttle_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/throttle_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/indexing/throttle_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/indexing/throttle_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/exists_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/exists_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/exists_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/exists_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/exists_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/exists_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/exists_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/exists_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/exists_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/exists_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/exists_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/exists_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/exists_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/exists_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/exists_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/exists_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/exists_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/exists_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/exists_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/exists_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/missing_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/missing_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/missing_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/missing_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/missing_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/missing_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/missing_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/missing_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/missing_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/missing_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/missing_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/missing_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/missing_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/missing_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/missing_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/missing_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/missing_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/missing_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/missing_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/missing_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/get/current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/get/current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/open_contexts/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/open_contexts/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/open_contexts/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/open_contexts/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/open_contexts/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/open_contexts/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/open_contexts/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/open_contexts/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/open_contexts/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/open_contexts/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/query_current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/query_current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/fetch_current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/fetch_current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/scroll_current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/scroll_current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/search/suggest_current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/search/suggest_current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current_docs/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current_docs/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current_docs/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current_docs/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current_docs/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current_docs/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current_docs/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current_docs/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current_docs/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current_docs/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current_size_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current_size_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current_size_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/current_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/current_size_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_docs/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_docs/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_docs/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_docs/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_docs/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_docs/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_docs/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_docs/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_docs/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_docs/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_size_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_size_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_size_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_size_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_stopped_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_stopped_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_stopped_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_stopped_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_stopped_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_stopped_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_stopped_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_stopped_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_stopped_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_stopped_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_throttled_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_throttled_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_throttled_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_throttled_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_throttled_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_throttled_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_throttled_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_throttled_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_throttled_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_throttled_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_auto_throttle_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_auto_throttle_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_auto_throttle_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_auto_throttle_in_bytes/min", "value"=>20971520, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_auto_throttle_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_auto_throttle_in_bytes/max", "value"=>20971520, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_auto_throttle_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_auto_throttle_in_bytes/sum", "value"=>41943040, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/merges/total_auto_throttle_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/merges/total_auto_throttle_in_bytes/avg", "value"=>20971520.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/total/min", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/total/max", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/total/sum", "value"=>4, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/total/avg", "value"=>2.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/total_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/total_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/total_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/total_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/total_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/total_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/total_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/total_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/total_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/total_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/external_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/external_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/external_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/external_total/min", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/external_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/external_total/max", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/external_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/external_total/sum", "value"=>4, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/external_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/external_total/avg", "value"=>2.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/external_total_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/external_total_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/external_total_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/external_total_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/external_total_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/external_total_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/external_total_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/external_total_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/external_total_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/external_total_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/listeners/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/listeners/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/listeners/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/listeners/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/listeners/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/listeners/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/listeners/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/listeners/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/refresh/listeners/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/refresh/listeners/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/periodic/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/periodic/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/periodic/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/periodic/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/periodic/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/periodic/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/periodic/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/periodic/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/periodic/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/periodic/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/total_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/total_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/total_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/total_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/total_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/total_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/total_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/total_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/flush/total_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/flush/total_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/total/min", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/total/max", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/total/sum", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/total/avg", "value"=>1.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/total_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/total_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/total_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/total_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/total_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/total_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/total_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/total_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/warmer/total_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/warmer/total_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/memory_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/memory_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/memory_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/memory_size_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/memory_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/memory_size_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/memory_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/memory_size_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/memory_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/memory_size_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/total_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/total_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/total_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/total_count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/total_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/total_count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/total_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/total_count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/total_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/total_count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/hit_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/hit_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/hit_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/hit_count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/hit_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/hit_count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/hit_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/hit_count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/hit_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/hit_count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/miss_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/miss_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/miss_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/miss_count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/miss_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/miss_count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/miss_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/miss_count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/miss_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/miss_count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/cache_size/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/cache_size/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/cache_size/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/cache_size/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/cache_size/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/cache_size/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/cache_size/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/cache_size/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/cache_size/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/cache_size/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/cache_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/cache_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/cache_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/cache_count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/cache_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/cache_count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/cache_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/cache_count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/cache_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/cache_count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/evictions/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/evictions/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/evictions/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/evictions/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/evictions/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/evictions/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/evictions/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/evictions/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/query_cache/evictions/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/query_cache/evictions/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/fielddata/memory_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/fielddata/memory_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/fielddata/memory_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/fielddata/memory_size_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/fielddata/memory_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/fielddata/memory_size_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/fielddata/memory_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/fielddata/memory_size_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/fielddata/memory_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/fielddata/memory_size_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/fielddata/evictions/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/fielddata/evictions/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/fielddata/evictions/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/fielddata/evictions/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/fielddata/evictions/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/fielddata/evictions/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/fielddata/evictions/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/fielddata/evictions/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/fielddata/evictions/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/fielddata/evictions/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/completion/size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/completion/size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/completion/size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/completion/size_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/completion/size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/completion/size_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/completion/size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/completion/size_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/completion/size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/completion/size_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/terms_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/terms_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/terms_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/terms_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/terms_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/terms_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/terms_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/terms_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/terms_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/terms_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/stored_fields_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/stored_fields_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/stored_fields_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/stored_fields_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/stored_fields_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/stored_fields_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/stored_fields_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/stored_fields_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/stored_fields_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/stored_fields_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/term_vectors_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/term_vectors_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/term_vectors_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/term_vectors_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/term_vectors_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/term_vectors_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/term_vectors_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/term_vectors_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/term_vectors_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/term_vectors_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/norms_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/norms_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/norms_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/norms_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/norms_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/norms_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/norms_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/norms_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/norms_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/norms_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/points_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/points_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/points_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/points_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/points_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/points_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/points_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/points_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/points_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/points_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/doc_values_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/doc_values_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/doc_values_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/doc_values_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/doc_values_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/doc_values_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/doc_values_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/doc_values_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/doc_values_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/doc_values_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/index_writer_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/index_writer_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/index_writer_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/index_writer_memory_in_bytes/min", "value"=>131676, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/index_writer_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/index_writer_memory_in_bytes/max", "value"=>131676, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/index_writer_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/index_writer_memory_in_bytes/sum", "value"=>263352, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/index_writer_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/index_writer_memory_in_bytes/avg", "value"=>131676.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/version_map_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/version_map_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/version_map_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/version_map_memory_in_bytes/min", "value"=>117, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/version_map_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/version_map_memory_in_bytes/max", "value"=>117, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/version_map_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/version_map_memory_in_bytes/sum", "value"=>234, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/version_map_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/version_map_memory_in_bytes/avg", "value"=>117.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/fixed_bit_set_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/fixed_bit_set_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/fixed_bit_set_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/fixed_bit_set_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/fixed_bit_set_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/fixed_bit_set_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/fixed_bit_set_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/fixed_bit_set_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/fixed_bit_set_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/fixed_bit_set_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/max_unsafe_auto_id_timestamp/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/max_unsafe_auto_id_timestamp/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/max_unsafe_auto_id_timestamp/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/max_unsafe_auto_id_timestamp/min", "value"=>-1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/max_unsafe_auto_id_timestamp/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/max_unsafe_auto_id_timestamp/max", "value"=>-1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/max_unsafe_auto_id_timestamp/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/max_unsafe_auto_id_timestamp/sum", "value"=>-2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/segments/max_unsafe_auto_id_timestamp/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/segments/max_unsafe_auto_id_timestamp/avg", "value"=>-1.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/operations/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/operations/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/operations/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/operations/min", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/operations/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/operations/max", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/operations/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/operations/sum", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/operations/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/operations/avg", "value"=>1.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/size_in_bytes/min", "value"=>165, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/size_in_bytes/max", "value"=>165, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/size_in_bytes/sum", "value"=>330, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/size_in_bytes/avg", "value"=>165.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/uncommitted_operations/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/uncommitted_operations/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/uncommitted_operations/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/uncommitted_operations/min", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/uncommitted_operations/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/uncommitted_operations/max", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/uncommitted_operations/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/uncommitted_operations/sum", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/uncommitted_operations/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/uncommitted_operations/avg", "value"=>1.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/uncommitted_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/uncommitted_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/uncommitted_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/uncommitted_size_in_bytes/min", "value"=>165, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/uncommitted_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/uncommitted_size_in_bytes/max", "value"=>165, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/uncommitted_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/uncommitted_size_in_bytes/sum", "value"=>330, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/uncommitted_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/uncommitted_size_in_bytes/avg", "value"=>165.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/earliest_last_modified_age/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/earliest_last_modified_age/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/earliest_last_modified_age/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/earliest_last_modified_age/min", "value"=>78079, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/earliest_last_modified_age/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/earliest_last_modified_age/max", "value"=>86292, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/earliest_last_modified_age/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/earliest_last_modified_age/sum", "value"=>164371, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/translog/earliest_last_modified_age/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/translog/earliest_last_modified_age/avg", "value"=>82185.5, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/memory_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/memory_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/memory_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/memory_size_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/memory_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/memory_size_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/memory_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/memory_size_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/memory_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/memory_size_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/evictions/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/evictions/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/evictions/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/evictions/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/evictions/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/evictions/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/evictions/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/evictions/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/evictions/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/evictions/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/hit_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/hit_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/hit_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/hit_count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/hit_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/hit_count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/hit_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/hit_count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/hit_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/hit_count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/miss_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/miss_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/miss_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/miss_count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/miss_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/miss_count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/miss_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/miss_count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/request_cache/miss_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/request_cache/miss_count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/current_as_source/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/current_as_source/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/current_as_source/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/current_as_source/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/current_as_source/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/current_as_source/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/current_as_source/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/current_as_source/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/current_as_source/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/current_as_source/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/current_as_target/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/current_as_target/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/current_as_target/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/current_as_target/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/current_as_target/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/current_as_target/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/current_as_target/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/current_as_target/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/current_as_target/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/current_as_target/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/throttle_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/throttle_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/throttle_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/throttle_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/throttle_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/throttle_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/throttle_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/throttle_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/primaries/recovery/throttle_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/primaries/recovery/throttle_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/docs/count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/docs/count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/docs/count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/docs/count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/docs/count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/docs/count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/docs/count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/docs/count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/docs/count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/docs/count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/docs/deleted/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/docs/deleted/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/docs/deleted/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/docs/deleted/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/docs/deleted/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/docs/deleted/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/docs/deleted/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/docs/deleted/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/docs/deleted/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/docs/deleted/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/shard_stats/total_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/shard_stats/total_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/shard_stats/total_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/shard_stats/total_count/min", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/shard_stats/total_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/shard_stats/total_count/max", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/shard_stats/total_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/shard_stats/total_count/sum", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/shard_stats/total_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/shard_stats/total_count/avg", "value"=>1.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/size_in_bytes/min", "value"=>226, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/size_in_bytes/max", "value"=>226, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/size_in_bytes/sum", "value"=>452, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/size_in_bytes/avg", "value"=>226.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/total_data_set_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/total_data_set_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/total_data_set_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/total_data_set_size_in_bytes/min", "value"=>226, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/total_data_set_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/total_data_set_size_in_bytes/max", "value"=>226, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/total_data_set_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/total_data_set_size_in_bytes/sum", "value"=>452, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/total_data_set_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/total_data_set_size_in_bytes/avg", "value"=>226.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/reserved_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/reserved_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/reserved_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/reserved_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/reserved_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/reserved_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/reserved_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/reserved_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/store/reserved_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/store/reserved_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_total/min", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_total/max", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_total/sum", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_total/avg", "value"=>1.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_time_in_millis/min", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_time_in_millis/max", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_time_in_millis/sum", "value"=>3, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_time_in_millis/avg", "value"=>1.5, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_failed/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_failed/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_failed/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_failed/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_failed/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_failed/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_failed/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_failed/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/index_failed/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/index_failed/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/delete_current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/delete_current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/noop_update_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/noop_update_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/noop_update_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/noop_update_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/noop_update_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/noop_update_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/noop_update_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/noop_update_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/noop_update_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/noop_update_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/throttle_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/throttle_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/throttle_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/throttle_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/throttle_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/throttle_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/throttle_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/throttle_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/indexing/throttle_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/indexing/throttle_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/exists_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/exists_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/exists_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/exists_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/exists_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/exists_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/exists_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/exists_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/exists_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/exists_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/exists_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/exists_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/exists_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/exists_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/exists_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/exists_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/exists_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/exists_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/exists_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/exists_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/missing_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/missing_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/missing_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/missing_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/missing_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/missing_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/missing_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/missing_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/missing_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/missing_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/missing_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/missing_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/missing_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/missing_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/missing_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/missing_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/missing_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/missing_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/missing_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/missing_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/get/current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/get/current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/open_contexts/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/open_contexts/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/open_contexts/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/open_contexts/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/open_contexts/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/open_contexts/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/open_contexts/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/open_contexts/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/open_contexts/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/open_contexts/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/query_current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/query_current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/fetch_current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/fetch_current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/scroll_current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/scroll_current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/search/suggest_current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/search/suggest_current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current_docs/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current_docs/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current_docs/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current_docs/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current_docs/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current_docs/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current_docs/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current_docs/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current_docs/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current_docs/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current_size_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current_size_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current_size_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/current_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/current_size_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_docs/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_docs/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_docs/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_docs/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_docs/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_docs/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_docs/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_docs/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_docs/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_docs/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_size_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_size_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_size_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_size_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_stopped_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_stopped_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_stopped_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_stopped_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_stopped_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_stopped_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_stopped_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_stopped_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_stopped_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_stopped_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_throttled_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_throttled_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_throttled_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_throttled_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_throttled_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_throttled_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_throttled_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_throttled_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_throttled_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_throttled_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_auto_throttle_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_auto_throttle_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_auto_throttle_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_auto_throttle_in_bytes/min", "value"=>20971520, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_auto_throttle_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_auto_throttle_in_bytes/max", "value"=>20971520, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_auto_throttle_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_auto_throttle_in_bytes/sum", "value"=>41943040, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/merges/total_auto_throttle_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/merges/total_auto_throttle_in_bytes/avg", "value"=>20971520.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/total/min", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/total/max", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/total/sum", "value"=>4, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/total/avg", "value"=>2.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/total_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/total_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/total_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/total_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/total_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/total_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/total_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/total_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/total_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/total_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/external_total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/external_total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/external_total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/external_total/min", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/external_total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/external_total/max", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/external_total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/external_total/sum", "value"=>4, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/external_total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/external_total/avg", "value"=>2.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/external_total_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/external_total_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/external_total_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/external_total_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/external_total_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/external_total_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/external_total_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/external_total_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/external_total_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/external_total_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/listeners/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/listeners/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/listeners/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/listeners/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/listeners/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/listeners/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/listeners/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/listeners/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/refresh/listeners/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/refresh/listeners/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/total/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/total/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/total/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/total/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/periodic/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/periodic/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/periodic/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/periodic/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/periodic/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/periodic/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/periodic/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/periodic/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/periodic/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/periodic/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/total_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/total_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/total_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/total_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/total_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/total_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/total_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/total_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/flush/total_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/flush/total_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/current/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/current/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/current/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/current/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/current/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/current/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/current/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/current/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/current/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/current/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/total/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/total/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/total/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/total/min", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/total/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/total/max", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/total/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/total/sum", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/total/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/total/avg", "value"=>1.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/total_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/total_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/total_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/total_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/total_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/total_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/total_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/total_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/warmer/total_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/warmer/total_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/memory_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/memory_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/memory_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/memory_size_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/memory_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/memory_size_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/memory_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/memory_size_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/memory_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/memory_size_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/total_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/total_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/total_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/total_count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/total_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/total_count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/total_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/total_count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/total_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/total_count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/hit_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/hit_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/hit_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/hit_count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/hit_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/hit_count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/hit_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/hit_count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/hit_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/hit_count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/miss_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/miss_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/miss_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/miss_count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/miss_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/miss_count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/miss_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/miss_count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/miss_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/miss_count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/cache_size/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/cache_size/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/cache_size/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/cache_size/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/cache_size/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/cache_size/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/cache_size/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/cache_size/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/cache_size/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/cache_size/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/cache_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/cache_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/cache_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/cache_count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/cache_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/cache_count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/cache_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/cache_count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/cache_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/cache_count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/evictions/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/evictions/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/evictions/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/evictions/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/evictions/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/evictions/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/evictions/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/evictions/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/query_cache/evictions/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/query_cache/evictions/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/fielddata/memory_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/fielddata/memory_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/fielddata/memory_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/fielddata/memory_size_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/fielddata/memory_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/fielddata/memory_size_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/fielddata/memory_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/fielddata/memory_size_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/fielddata/memory_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/fielddata/memory_size_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/fielddata/evictions/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/fielddata/evictions/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/fielddata/evictions/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/fielddata/evictions/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/fielddata/evictions/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/fielddata/evictions/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/fielddata/evictions/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/fielddata/evictions/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/fielddata/evictions/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/fielddata/evictions/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/completion/size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/completion/size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/completion/size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/completion/size_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/completion/size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/completion/size_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/completion/size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/completion/size_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/completion/size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/completion/size_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/terms_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/terms_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/terms_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/terms_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/terms_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/terms_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/terms_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/terms_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/terms_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/terms_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/stored_fields_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/stored_fields_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/stored_fields_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/stored_fields_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/stored_fields_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/stored_fields_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/stored_fields_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/stored_fields_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/stored_fields_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/stored_fields_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/term_vectors_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/term_vectors_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/term_vectors_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/term_vectors_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/term_vectors_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/term_vectors_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/term_vectors_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/term_vectors_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/term_vectors_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/term_vectors_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/norms_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/norms_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/norms_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/norms_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/norms_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/norms_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/norms_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/norms_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/norms_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/norms_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/points_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/points_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/points_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/points_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/points_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/points_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/points_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/points_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/points_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/points_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/doc_values_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/doc_values_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/doc_values_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/doc_values_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/doc_values_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/doc_values_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/doc_values_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/doc_values_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/doc_values_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/doc_values_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/index_writer_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/index_writer_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/index_writer_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/index_writer_memory_in_bytes/min", "value"=>131676, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/index_writer_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/index_writer_memory_in_bytes/max", "value"=>131676, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/index_writer_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/index_writer_memory_in_bytes/sum", "value"=>263352, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/index_writer_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/index_writer_memory_in_bytes/avg", "value"=>131676.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/version_map_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/version_map_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/version_map_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/version_map_memory_in_bytes/min", "value"=>117, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/version_map_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/version_map_memory_in_bytes/max", "value"=>117, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/version_map_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/version_map_memory_in_bytes/sum", "value"=>234, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/version_map_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/version_map_memory_in_bytes/avg", "value"=>117.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/fixed_bit_set_memory_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/fixed_bit_set_memory_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/fixed_bit_set_memory_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/fixed_bit_set_memory_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/fixed_bit_set_memory_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/fixed_bit_set_memory_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/fixed_bit_set_memory_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/fixed_bit_set_memory_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/fixed_bit_set_memory_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/fixed_bit_set_memory_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/max_unsafe_auto_id_timestamp/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/max_unsafe_auto_id_timestamp/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/max_unsafe_auto_id_timestamp/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/max_unsafe_auto_id_timestamp/min", "value"=>-1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/max_unsafe_auto_id_timestamp/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/max_unsafe_auto_id_timestamp/max", "value"=>-1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/max_unsafe_auto_id_timestamp/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/max_unsafe_auto_id_timestamp/sum", "value"=>-2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/segments/max_unsafe_auto_id_timestamp/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/segments/max_unsafe_auto_id_timestamp/avg", "value"=>-1.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/operations/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/operations/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/operations/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/operations/min", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/operations/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/operations/max", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/operations/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/operations/sum", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/operations/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/operations/avg", "value"=>1.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/size_in_bytes/min", "value"=>165, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/size_in_bytes/max", "value"=>165, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/size_in_bytes/sum", "value"=>330, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/size_in_bytes/avg", "value"=>165.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/uncommitted_operations/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/uncommitted_operations/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/uncommitted_operations/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/uncommitted_operations/min", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/uncommitted_operations/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/uncommitted_operations/max", "value"=>1, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/uncommitted_operations/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/uncommitted_operations/sum", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/uncommitted_operations/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/uncommitted_operations/avg", "value"=>1.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/uncommitted_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/uncommitted_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/uncommitted_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/uncommitted_size_in_bytes/min", "value"=>165, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/uncommitted_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/uncommitted_size_in_bytes/max", "value"=>165, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/uncommitted_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/uncommitted_size_in_bytes/sum", "value"=>330, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/uncommitted_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/uncommitted_size_in_bytes/avg", "value"=>165.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/earliest_last_modified_age/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/earliest_last_modified_age/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/earliest_last_modified_age/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/earliest_last_modified_age/min", "value"=>78079, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/earliest_last_modified_age/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/earliest_last_modified_age/max", "value"=>86292, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/earliest_last_modified_age/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/earliest_last_modified_age/sum", "value"=>164371, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/translog/earliest_last_modified_age/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/translog/earliest_last_modified_age/avg", "value"=>82185.5, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/memory_size_in_bytes/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/memory_size_in_bytes/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/memory_size_in_bytes/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/memory_size_in_bytes/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/memory_size_in_bytes/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/memory_size_in_bytes/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/memory_size_in_bytes/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/memory_size_in_bytes/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/memory_size_in_bytes/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/memory_size_in_bytes/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/evictions/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/evictions/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/evictions/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/evictions/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/evictions/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/evictions/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/evictions/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/evictions/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/evictions/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/evictions/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/hit_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/hit_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/hit_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/hit_count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/hit_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/hit_count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/hit_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/hit_count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/hit_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/hit_count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/miss_count/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/miss_count/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/miss_count/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/miss_count/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/miss_count/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/miss_count/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/miss_count/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/miss_count/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/request_cache/miss_count/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/request_cache/miss_count/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/current_as_source/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/current_as_source/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/current_as_source/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/current_as_source/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/current_as_source/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/current_as_source/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/current_as_source/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/current_as_source/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/current_as_source/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/current_as_source/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/current_as_target/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/current_as_target/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/current_as_target/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/current_as_target/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/current_as_target/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/current_as_target/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/current_as_target/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/current_as_target/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/current_as_target/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/current_as_target/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/throttle_time_in_millis/count metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/throttle_time_in_millis/count", "value"=>2, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/throttle_time_in_millis/min metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/throttle_time_in_millis/min", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/throttle_time_in_millis/max metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/throttle_time_in_millis/max", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/throttle_time_in_millis/sum metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/throttle_time_in_millis/sum", "value"=>0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end

      test 'it has indices/total/recovery/throttle_time_in_millis/avg metric' do
        metric = create_full_agr_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)
        expected_metric = {"index"=>"log", "aggregated"=>true, "index_base"=>"log", "timestamp"=>TEST_TIME_ISO, "name"=>"indices/total/recovery/throttle_time_in_millis/avg", "value"=>0.0, "family"=>"indices_stats"}
        metrics = data.extract_metrics
        assert metrics.include?(expected_metric)
      end
    end

    sub_test_case 'aggregated indices only' do
      test 'it has indices/count metric' do
        metric = create_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1',
                               aggregated_index_metrics_only: true)
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)

        metrics = data.extract_metrics

        expected = metrics.find { |metric| metric['name'] == 'indices/count' }
        assert expected
      end

      test 'it has all_indices metrics' do
        metric = create_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1',
                               aggregated_index_metrics_only: true)
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)

        metrics = data.extract_metrics

        expected = metrics.find { |metric| metric['name'].start_with?('all_indices') }
        assert expected
      end

      test 'it has no indices metrics' do
        metric = create_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1',
                               aggregated_index_metrics_only: true)
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)

        metrics = data.extract_metrics

        expected = metrics.find { |metric| metric['name'].start_with?('index') && !metric['aggregated'] }
        refute expected
      end

      test 'it has aggregated indices metrics' do
        metric = create_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1',
                               aggregated_index_metrics_only: true)
        data = create_data(data: fixture_json('indices_stats__indices'), metric: metric)

        metrics = data.extract_metrics

        expected = metrics.find { |metric| metric['name'].start_with?('indices') && metric['aggregated'] }
        assert expected
      end
    end
  end
end
