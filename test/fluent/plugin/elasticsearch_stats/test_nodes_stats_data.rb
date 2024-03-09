# frozen_string_literal: true

require 'helper'
require 'fluent/plugin/elasticsearch_stats/cluster_health_data'

class NodesStatsDataTest < Test::Unit::TestCase
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
    Fluent::Plugin::ElasticsearchStats::NodesStatsData.new(
      data,
      **params
    )
  end

  sub_test_case 'nodes_stats node/indices metrics' do
    test 'it has docs_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/docs/count', 'value' => 65, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has docs_deleted' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/docs/deleted', 'value' => 39, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has shard_stats_total_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/shard_stats/total_count', 'value' => 4, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has store_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/store/size_in_bytes', 'value' => 38_936_314, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has store_total_data_set_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/store/total_data_set_size_in_bytes', 'value' => 38_936_314, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has store_reserved_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/store/reserved_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has indexing_index_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/indexing/index_total', 'value' => 40, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has indexing_index_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/indexing/index_time_in_millis', 'value' => 604, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has indexing_index_current' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/indexing/index_current', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has indexing_index_failed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/indexing/index_failed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has indexing_delete_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/indexing/delete_total', 'value' => 39, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has indexing_delete_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/indexing/delete_time_in_millis', 'value' => 16, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has indexing_delete_current' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/indexing/delete_current', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has indexing_noop_update_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/indexing/noop_update_total', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has indexing_throttle_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/indexing/throttle_time_in_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z', 'name' => 'node/indices/get/total',
                          'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/get/time_in_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_exists_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/get/exists_total', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_exists_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/get/exists_time_in_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_missing_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/get/missing_total', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_missing_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/get/missing_time_in_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_current' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/get/current', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_open_contexts' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/open_contexts', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_query_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/query_total', 'value' => 84, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_query_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/query_time_in_millis', 'value' => 129, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_query_current' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/query_current', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_fetch_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/fetch_total', 'value' => 84, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_fetch_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/fetch_time_in_millis', 'value' => 576, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_fetch_current' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/fetch_current', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_scroll_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/scroll_total', 'value' => 3, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_scroll_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/scroll_time_in_millis', 'value' => 105, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_scroll_current' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/scroll_current', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_suggest_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/suggest_total', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_suggest_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/suggest_time_in_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_suggest_current' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/search/suggest_current', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has merges_current' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/merges/current', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has merges_current_docs' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/merges/current_docs', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has merges_current_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/merges/current_size_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has merges_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/merges/total', 'value' => 2, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has merges_total_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/merges/total_time_in_millis', 'value' => 1479, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has merges_total_docs' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/merges/total_docs', 'value' => 200, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has merges_total_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/merges/total_size_in_bytes', 'value' => 121_166_918, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has merges_total_stopped_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/merges/total_stopped_time_in_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has merges_total_throttled_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/merges/total_throttled_time_in_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has merges_total_auto_throttle_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/merges/total_auto_throttle_in_bytes', 'value' => 83_886_080, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has refresh_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/refresh/total', 'value' => 23, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has refresh_total_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/refresh/total_time_in_millis', 'value' => 49, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has refresh_external_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/refresh/external_total', 'value' => 18, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has refresh_external_total_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/refresh/external_total_time_in_millis', 'value' => 60, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has refresh_listeners' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/refresh/listeners', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has flush_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/flush/total', 'value' => 7, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has flush_periodic' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/flush/periodic', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has flush_total_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/flush/total_time_in_millis', 'value' => 306, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has warmer_current' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/warmer/current', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has warmer_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/warmer/total', 'value' => 13, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has warmer_total_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/warmer/total_time_in_millis', 'value' => 4, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has query_cache_memory_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/query_cache/memory_size_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has query_cache_total_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/query_cache/total_count', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has query_cache_hit_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/query_cache/hit_count', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has query_cache_miss_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/query_cache/miss_count', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has query_cache_cache_size' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/query_cache/cache_size', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has query_cache_cache_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/query_cache/cache_count', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has query_cache_evictions' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/query_cache/evictions', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fielddata_memory_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/fielddata/memory_size_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fielddata_evictions' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/fielddata/evictions', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has completion_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/completion/size_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has segments_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/segments/count', 'value' => 9, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has segments_memory_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/segments/memory_in_bytes', 'value' => 26_972, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has segments_terms_memory_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/segments/terms_memory_in_bytes', 'value' => 20_736, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has segments_stored_fields_memory_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/segments/stored_fields_memory_in_bytes', 'value' => 4440, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has segments_term_vectors_memory_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/segments/term_vectors_memory_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has segments_norms_memory_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/segments/norms_memory_in_bytes', 'value' => 512, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has segments_points_memory_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/segments/points_memory_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has segments_doc_values_memory_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/segments/doc_values_memory_in_bytes', 'value' => 1284, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has segments_index_writer_memory_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/segments/index_writer_memory_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has segments_version_map_memory_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/segments/version_map_memory_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has segments_fixed_bit_set_memory_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/segments/fixed_bit_set_memory_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has segments_max_unsafe_auto_id_timestamp' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/segments/max_unsafe_auto_id_timestamp', 'value' => -1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has translog_operations' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/translog/operations', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has translog_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/translog/size_in_bytes', 'value' => 220, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has translog_uncommitted_operations' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/translog/uncommitted_operations', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has translog_uncommitted_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/translog/uncommitted_size_in_bytes', 'value' => 220, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has translog_earliest_last_modified_age' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/translog/earliest_last_modified_age', 'value' => 19_064_884, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has request_cache_memory_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/request_cache/memory_size_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has request_cache_evictions' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/request_cache/evictions', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has request_cache_hit_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/request_cache/hit_count', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has request_cache_miss_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/request_cache/miss_count', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has recovery_current_as_source' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/recovery/current_as_source', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has recovery_current_as_target' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/recovery/current_as_target', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has recovery_throttle_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indices/recovery/throttle_time_in_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats node/os metrics' do
    test 'it has cpu_percent' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/cpu/percent', 'value' => 10, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cpu_load_average_1m' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/cpu/load_average/1m', 'value' => 0.42, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cpu_load_average_5m' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/cpu/load_average/5m', 'value' => 0.82, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cpu_load_average_15m' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/cpu/load_average/15m', 'value' => 1.01, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_total_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/mem/total_in_bytes', 'value' => 32_366_747_648, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_free_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/mem/free_in_bytes', 'value' => 1_759_789_056, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_used_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/mem/used_in_bytes', 'value' => 30_606_958_592, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_free_percent' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/mem/free_percent', 'value' => 5, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_used_percent' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/mem/used_percent', 'value' => 95, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has swap_total_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/swap/total_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has swap_free_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/swap/free_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has swap_used_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/swap/used_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cgroup_cpuacct_usage_nanos' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/cgroup/cpuacct/usage_nanos', 'value' => 21_407_325_257, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cgroup_cpu_cfs_period_micros' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/cgroup/cpu/cfs_period_micros', 'value' => 100_000, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cgroup_cpu_cfs_quota_micros' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/cgroup/cpu/cfs_quota_micros', 'value' => -1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cgroup_cpu_stat_number_of_elapsed_periods' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/cgroup/cpu/stat/number_of_elapsed_periods', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cgroup_cpu_stat_number_of_times_throttled' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/cgroup/cpu/stat/number_of_times_throttled', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cgroup_cpu_stat_time_throttled_nanos' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/os/cgroup/cpu/stat/time_throttled_nanos', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats node/process metrics' do
    test 'it has open_file_descriptors' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/process/open_file_descriptors', 'value' => 340, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has max_file_descriptors' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/process/max_file_descriptors', 'value' => 1_048_576, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cpu_percent' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/process/cpu/percent', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cpu_total_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/process/cpu/total_in_millis', 'value' => 152_290, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_total_virtual_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/process/mem/total_virtual_in_bytes', 'value' => 25_979_826_176, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats node/jvm metrics' do
    test 'it has uptime_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/uptime_in_millis', 'value' => 19_383_546, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_heap_used_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/heap_used_in_bytes', 'value' => 1_932_353_184, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_heap_used_percent' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/heap_used_percent', 'value' => 11, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_heap_committed_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/heap_committed_in_bytes', 'value' => 16_190_013_440, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_heap_max_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/heap_max_in_bytes', 'value' => 16_190_013_440, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_non_heap_used_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/non_heap_used_in_bytes', 'value' => 153_776_848, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_non_heap_committed_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/non_heap_committed_in_bytes', 'value' => 158_531_584, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_pools_young_used_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/pools/young/used_in_bytes', 'value' => 1_828_716_544, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_pools_young_max_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/pools/young/max_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_pools_young_peak_used_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/pools/young/peak_used_in_bytes', 'value' => 9_663_676_416, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_pools_young_peak_max_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/pools/young/peak_max_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_pools_old_used_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/pools/old/used_in_bytes', 'value' => 54_598_144, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_pools_old_max_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/pools/old/max_in_bytes', 'value' => 16_190_013_440, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_pools_old_peak_used_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/pools/old/peak_used_in_bytes', 'value' => 54_598_144, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_pools_old_peak_max_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/pools/old/peak_max_in_bytes', 'value' => 16_190_013_440, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_pools_survivor_used_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/pools/survivor/used_in_bytes', 'value' => 49_038_496, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_pools_survivor_max_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/pools/survivor/max_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_pools_survivor_peak_used_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/pools/survivor/peak_used_in_bytes', 'value' => 70_773_544, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has mem_pools_survivor_peak_max_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/mem/pools/survivor/peak_max_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has threads_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/threads/count', 'value' => 72, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has threads_peak_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/threads/peak_count', 'value' => 80, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has gc_collectors_young_collection_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/gc/collectors/young/collection_count', 'value' => 10, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has gc_collectors_young_collection_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/gc/collectors/young/collection_time_in_millis', 'value' => 171, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has gc_collectors_old_collection_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/gc/collectors/old/collection_count', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has gc_collectors_old_collection_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/gc/collectors/old/collection_time_in_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has buffer_pools_mapped_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/buffer_pools/mapped/count', 'value' => 20, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has buffer_pools_mapped_used_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/buffer_pools/mapped/used_in_bytes', 'value' => 66_981, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has buffer_pools_mapped_total_capacity_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/buffer_pools/mapped/total_capacity_in_bytes', 'value' => 66_981, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has buffer_pools_direct_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/buffer_pools/direct/count', 'value' => 45, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has buffer_pools_direct_used_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/buffer_pools/direct/used_in_bytes', 'value' => 2_816_211, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has buffer_pools_direct_total_capacity_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/buffer_pools/direct/total_capacity_in_bytes', 'value' => 2_816_210, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has buffer_pools_mapped_count bis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => "node/jvm/buffer_pools/mapped - 'non-volatile memory'/count", 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has buffer_pools_mapped_used_in_bytes bis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => "node/jvm/buffer_pools/mapped - 'non-volatile memory'/used_in_bytes", 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has buffer_pools_mapped_total_capacity_in_bytes bis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => "node/jvm/buffer_pools/mapped - 'non-volatile memory'/total_capacity_in_bytes", 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has classes_current_loaded_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/classes/current_loaded_count', 'value' => 24_583, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has classes_total_loaded_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/classes/total_loaded_count', 'value' => 24_583, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has classes_total_unloaded_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/jvm/classes/total_unloaded_count', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats/thread_pool metrics' do
    test 'it has analyze_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/analyze/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has analyze_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/analyze/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has analyze_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/analyze/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has analyze_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/analyze/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has analyze_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/analyze/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has analyze_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/analyze/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has auto_complete_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/auto_complete/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has auto_complete_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/auto_complete/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has auto_complete_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/auto_complete/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has auto_complete_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/auto_complete/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has auto_complete_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/auto_complete/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has auto_complete_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/auto_complete/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ccr_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ccr/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ccr_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z', 'name' => 'node/thread_pool/ccr/queue',
                          'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ccr_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ccr/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ccr_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ccr/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ccr_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ccr/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ccr_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ccr/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fetch_shard_started_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/fetch_shard_started/threads', 'value' => 1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fetch_shard_started_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/fetch_shard_started/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fetch_shard_started_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/fetch_shard_started/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fetch_shard_started_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/fetch_shard_started/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fetch_shard_started_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/fetch_shard_started/largest', 'value' => 4, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fetch_shard_started_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/fetch_shard_started/completed', 'value' => 4, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fetch_shard_store_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/fetch_shard_store/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fetch_shard_store_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/fetch_shard_store/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fetch_shard_store_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/fetch_shard_store/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fetch_shard_store_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/fetch_shard_store/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fetch_shard_store_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/fetch_shard_store/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fetch_shard_store_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/fetch_shard_store/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has flush_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/flush/threads', 'value' => 1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has flush_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/flush/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has flush_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/flush/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has flush_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/flush/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has flush_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/flush/largest', 'value' => 2, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has flush_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/flush/completed', 'value' => 7, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has force_merge_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/force_merge/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has force_merge_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/force_merge/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has force_merge_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/force_merge/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has force_merge_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/force_merge/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has force_merge_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/force_merge/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has force_merge_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/force_merge/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has generic_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/generic/threads', 'value' => 11, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has generic_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/generic/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has generic_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/generic/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has generic_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/generic/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has generic_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/generic/largest', 'value' => 11, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has generic_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/generic/completed', 'value' => 25_639, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/get/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z', 'name' => 'node/thread_pool/get/queue',
                          'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/get/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/get/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/get/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has get_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/get/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has listener_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/listener/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has listener_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/listener/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has listener_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/listener/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has listener_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/listener/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has listener_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/listener/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has listener_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/listener/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has management_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/management/threads', 'value' => 5, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has management_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/management/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has management_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/management/active', 'value' => 1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has management_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/management/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has management_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/management/largest', 'value' => 5, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has management_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/management/completed', 'value' => 6564, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_datafeed_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_datafeed/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_datafeed_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_datafeed/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_datafeed_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_datafeed/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_datafeed_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_datafeed/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_datafeed_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_datafeed/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_datafeed_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_datafeed/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_job_comms_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_job_comms/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_job_comms_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_job_comms/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_job_comms_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_job_comms/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_job_comms_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_job_comms/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_job_comms_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_job_comms/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_job_comms_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_job_comms/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_utility_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_utility/threads', 'value' => 1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_utility_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_utility/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_utility_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_utility/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_utility_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_utility/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_utility_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_utility/largest', 'value' => 1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has ml_utility_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/ml_utility/completed', 'value' => 19_360, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has refresh_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/refresh/threads', 'value' => 4, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has refresh_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/refresh/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has refresh_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/refresh/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has refresh_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/refresh/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has refresh_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/refresh/largest', 'value' => 4, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has refresh_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/refresh/completed', 'value' => 77_435, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has rollup_indexing_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/rollup_indexing/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has rollup_indexing_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/rollup_indexing/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has rollup_indexing_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/rollup_indexing/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has rollup_indexing_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/rollup_indexing/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has rollup_indexing_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/rollup_indexing/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has rollup_indexing_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/rollup_indexing/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_coordination_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search_coordination/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_coordination_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search_coordination/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_coordination_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search_coordination/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_coordination_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search_coordination/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_coordination_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search_coordination/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_coordination_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search_coordination/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_throttled_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search_throttled/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_throttled_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search_throttled/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_throttled_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search_throttled/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_throttled_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search_throttled/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_throttled_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search_throttled/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has search_throttled_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/search_throttled/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has searchable_snapshots_cache_fetch_async_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/searchable_snapshots_cache_fetch_async/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has searchable_snapshots_cache_fetch_async_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/searchable_snapshots_cache_fetch_async/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has searchable_snapshots_cache_fetch_async_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/searchable_snapshots_cache_fetch_async/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has searchable_snapshots_cache_fetch_async_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/searchable_snapshots_cache_fetch_async/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has searchable_snapshots_cache_fetch_async_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/searchable_snapshots_cache_fetch_async/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has searchable_snapshots_cache_fetch_async_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/searchable_snapshots_cache_fetch_async/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has searchable_snapshots_cache_prewarming_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/searchable_snapshots_cache_prewarming/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has searchable_snapshots_cache_prewarming_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/searchable_snapshots_cache_prewarming/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has searchable_snapshots_cache_prewarming_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/searchable_snapshots_cache_prewarming/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has searchable_snapshots_cache_prewarming_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/searchable_snapshots_cache_prewarming/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has searchable_snapshots_cache_prewarming_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/searchable_snapshots_cache_prewarming/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has searchable_snapshots_cache_prewarming_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/searchable_snapshots_cache_prewarming/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has security-crypto_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/security-crypto/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has security-crypto_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/security-crypto/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has security-crypto_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/security-crypto/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has security-crypto_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/security-crypto/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has security-crypto_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/security-crypto/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has security-crypto_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/security-crypto/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has security-token-key_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/security-token-key/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has security-token-key_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/security-token-key/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has security-token-key_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/security-token-key/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has security-token-key_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/security-token-key/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has security-token-key_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/security-token-key/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has security-token-key_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/security-token-key/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has snapshot_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/snapshot/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has snapshot_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/snapshot/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has snapshot_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/snapshot/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has snapshot_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/snapshot/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has snapshot_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/snapshot/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has snapshot_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/snapshot/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has snapshot_meta_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/snapshot_meta/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has snapshot_meta_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/snapshot_meta/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has snapshot_meta_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/snapshot_meta/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has snapshot_meta_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/snapshot_meta/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has snapshot_meta_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/snapshot_meta/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has snapshot_meta_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/snapshot_meta/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_critical_read_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_critical_read/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_critical_read_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_critical_read/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_critical_read_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_critical_read/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_critical_read_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_critical_read/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_critical_read_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_critical_read/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_critical_read_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_critical_read/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_critical_write_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_critical_write/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_critical_write_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_critical_write/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_critical_write_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_critical_write/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_critical_write_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_critical_write/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_critical_write_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_critical_write/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_critical_write_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_critical_write/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_read_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_read/threads', 'value' => 5, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_read_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_read/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_read_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_read/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_read_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_read/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_read_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_read/largest', 'value' => 5, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_read_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_read/completed', 'value' => 165, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_write_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_write/threads', 'value' => 5, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_write_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_write/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_write_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_write/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_write_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_write/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_write_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_write/largest', 'value' => 5, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has system_write_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/system_write/completed', 'value' => 78, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has transform_indexing_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/transform_indexing/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has transform_indexing_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/transform_indexing/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has transform_indexing_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/transform_indexing/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has transform_indexing_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/transform_indexing/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has transform_indexing_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/transform_indexing/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has transform_indexing_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/transform_indexing/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has vector_tile_generation_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/vector_tile_generation/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has vector_tile_generation_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/vector_tile_generation/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has vector_tile_generation_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/vector_tile_generation/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has vector_tile_generation_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/vector_tile_generation/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has vector_tile_generation_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/vector_tile_generation/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has vector_tile_generation_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/vector_tile_generation/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has warmer_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/warmer/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has warmer_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/warmer/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has warmer_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/warmer/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has warmer_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/warmer/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has warmer_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/warmer/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has warmer_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/warmer/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has watcher_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/watcher/threads', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has watcher_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/watcher/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has watcher_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/watcher/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has watcher_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/watcher/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has watcher_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/watcher/largest', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has watcher_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/watcher/completed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has write_threads' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/write/threads', 'value' => 1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has write_queue' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/write/queue', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has write_active' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/write/active', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has write_rejected' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/write/rejected', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has write_largest' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/write/largest', 'value' => 1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has write_completed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/thread_pool/write/completed', 'value' => 1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats/fs metrics' do
    test 'it has total_total_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/fs/total/total_in_bytes', 'value' => 927_154_307_072, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has total_free_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/fs/total/free_in_bytes', 'value' => 551_931_609_088, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has total_available_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/fs/total/available_in_bytes', 'value' => 551_931_609_088, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats/transport metrics' do
    test 'it has server_open' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/transport/server_open', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has total_outbound_connections' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/transport/total_outbound_connections', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has rx_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z', 'name' => 'node/transport/rx_count',
                          'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has rx_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/transport/rx_size_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has tx_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z', 'name' => 'node/transport/tx_count',
                          'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has tx_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/transport/tx_size_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats/http metrics' do
    test 'it has current_open' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/http/current_open', 'value' => 1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has total_opened' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/http/total_opened', 'value' => 2, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats/breakers metrics' do
    test 'it has request_limit_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/request/limit_size_in_bytes', 'value' => 9_714_008_064, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has request_estimated_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/request/estimated_size_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has request_overhead' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/request/overhead', 'value' => 1.0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has request_tripped' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/request/tripped', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fielddata_limit_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/fielddata/limit_size_in_bytes', 'value' => 6_476_005_376, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fielddata_estimated_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/fielddata/estimated_size_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fielddata_overhead' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/fielddata/overhead', 'value' => 1.03, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has fielddata_tripped' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/fielddata/tripped', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has in_flight_requests_limit_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/in_flight_requests/limit_size_in_bytes', 'value' => 16_190_013_440, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has in_flight_requests_estimated_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/in_flight_requests/estimated_size_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has in_flight_requests_overhead' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/in_flight_requests/overhead', 'value' => 2.0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has in_flight_requests_tripped' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/in_flight_requests/tripped', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has model_inference_limit_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/model_inference/limit_size_in_bytes', 'value' => 8_095_006_720, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has model_inference_estimated_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/model_inference/estimated_size_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has model_inference_overhead' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/model_inference/overhead', 'value' => 1.0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has model_inference_tripped' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/model_inference/tripped', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has eql_sequence_limit_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/eql_sequence/limit_size_in_bytes', 'value' => 8_095_006_720, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has eql_sequence_estimated_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/eql_sequence/estimated_size_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has eql_sequence_overhead' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/eql_sequence/overhead', 'value' => 1.0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has eql_sequence_tripped' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/eql_sequence/tripped', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has accounting_limit_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/accounting/limit_size_in_bytes', 'value' => 16_190_013_440, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has accounting_estimated_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/accounting/estimated_size_in_bytes', 'value' => 26_972, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has accounting_overhead' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/accounting/overhead', 'value' => 1.0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has accounting_tripped' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/accounting/tripped', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has parent_limit_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/parent/limit_size_in_bytes', 'value' => 15_380_512_768, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has parent_estimated_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/parent/estimated_size_in_bytes', 'value' => 1_932_353_184, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has parent_overhead' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/parent/overhead', 'value' => 1.0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has parent_tripped' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/breakers/parent/tripped', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats node/script metrics' do
    test 'it has compilations' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/script/compilations', 'value' => 1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cache_evictions' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/script/cache_evictions', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has compilation_limit_triggered' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/script/compilation_limit_triggered', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats node/discovery metrics' do
    test 'it has cluster_state_queue_total' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_queue/total', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_queue_pending' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_queue/pending', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_queue_committed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_queue/committed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has serialized_cluster_states_full_states_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/serialized_cluster_states/full_states/count', 'value' => 2, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has serialized_cluster_states_full_states_uncompressed_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/serialized_cluster_states/full_states/uncompressed_size_in_bytes', 'value' => 48_335, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has serialized_cluster_states_full_states_compressed_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/serialized_cluster_states/full_states/compressed_size_in_bytes', 'value' => 28_029, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has serialized_cluster_states_diffs_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/serialized_cluster_states/diffs/count', 'value' => 7, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has serialized_cluster_states_diffs_uncompressed_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/serialized_cluster_states/diffs/uncompressed_size_in_bytes', 'value' => 8664, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has serialized_cluster_states_diffs_compressed_size_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/serialized_cluster_states/diffs/compressed_size_in_bytes', 'value' => 3397, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has published_cluster_states_full_states' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/published_cluster_states/full_states', 'value' => 2, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has published_cluster_states_incompatible_diffs' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/published_cluster_states/incompatible_diffs', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has published_cluster_states_compatible_diffs' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/published_cluster_states/compatible_diffs', 'value' => 7, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_unchanged_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/unchanged/count', 'value' => 43, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_unchanged_computation_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/unchanged/computation_time_millis', 'value' => 9, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_unchanged_notification_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/unchanged/notification_time_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_success_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/success/count', 'value' => 9, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_success_computation_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/success/computation_time_millis', 'value' => 36, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_success_publication_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/success/publication_time_millis', 'value' => 721, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_success_context_construction_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/success/context_construction_time_millis', 'value' => 20, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_success_commit_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/success/commit_time_millis', 'value' => 148, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_success_completion_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/success/completion_time_millis', 'value' => 153, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_success_master_apply_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/success/master_apply_time_millis', 'value' => 537, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_success_notification_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/success/notification_time_millis', 'value' => 2, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_failure_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/failure/count', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_failure_computation_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/failure/computation_time_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_failure_publication_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/failure/publication_time_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_failure_context_construction_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/failure/context_construction_time_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_failure_commit_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/failure/commit_time_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_failure_completion_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/failure/completion_time_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_failure_master_apply_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/failure/master_apply_time_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_state_update_failure_notification_time_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/discovery/cluster_state_update/failure/notification_time_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats node/ingest metrics' do
    test 'it has total_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/ingest/total/count', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has total_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/ingest/total/time_in_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has total_current' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/ingest/total/current', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has total_failed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/ingest/total/failed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has pipelines_xpack_monitoring_6_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/ingest/pipelines/xpack_monitoring_6/count', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has pipelines_xpack_monitoring_6_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/ingest/pipelines/xpack_monitoring_6/time_in_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has pipelines_xpack_monitoring_6_current' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/ingest/pipelines/xpack_monitoring_6/current', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has pipelines_xpack_monitoring_6_failed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/ingest/pipelines/xpack_monitoring_6/failed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has pipelines_xpack_monitoring_7_count' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/ingest/pipelines/xpack_monitoring_7/count', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has pipelines_xpack_monitoring_7_time_in_millis' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/ingest/pipelines/xpack_monitoring_7/time_in_millis', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has pipelines_xpack_monitoring_7_current' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/ingest/pipelines/xpack_monitoring_7/current', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has pipelines_xpack_monitoring_7_failed' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/ingest/pipelines/xpack_monitoring_7/failed', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats node/script_cache metrics' do
    test 'it has sum_compilations' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/script_cache/sum/compilations', 'value' => 1, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has sum_cache_evictions' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/script_cache/sum/cache_evictions', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has sum_compilation_limit_triggered' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/script_cache/sum/compilation_limit_triggered', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'nodes_stats node/indexing/pressure metrics' do
    test 'it has memory_current_combined_coordinating_and_primary_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/current/combined_coordinating_and_primary_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_current_coordinating_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/current/coordinating_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_current_primary_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/current/primary_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_current_replica_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/current/replica_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_current_all_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/current/all_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_total_combined_coordinating_and_primary_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/total/combined_coordinating_and_primary_in_bytes', 'value' => 39_251_541, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_total_coordinating_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/total/coordinating_in_bytes', 'value' => 39_251_541, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_total_primary_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/total/primary_in_bytes', 'value' => 39_252_829, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_total_replica_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/total/replica_in_bytes', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_total_all_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/total/all_in_bytes', 'value' => 39_251_541, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_total_coordinating_rejections' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/total/coordinating_rejections', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_total_primary_rejections' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/total/primary_rejections', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_total_replica_rejections' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/total/replica_rejections', 'value' => 0, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has memory_limit_in_bytes' do
      data = create_data(data: fixture_json('nodes_stats__indices'))
      expected_metric = { 'cluster_name' => 'elasticsearch', 'timestamp' => '2024-01-01T00:00:00.000Z',
                          'name' => 'node/indexing_pressure/memory/limit_in_bytes', 'value' => 1_619_001_344, 'family' => 'nodes_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end
end
