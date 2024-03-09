# frozen_string_literal: true

require 'helper'
require 'fluent/plugin/elasticsearch_stats/cluster_health_data'

class ClusterStatsDataTest < Test::Unit::TestCase
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
    Fluent::Plugin::ElasticsearchStats::ClusterStatsData.new(
      data,
      **params
    )
  end

  sub_test_case 'cluster_stats status metrics' do
    test 'it has status metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'timestamp' => TEST_TIME_ISO,
                          'name' => 'cluster/status',
                          'value' => 1,
                          'family' => 'cluster_stats',
                          'cluster_name' => 'elasticsearch' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'cluster_stats metrics' do
    test 'it has cluster_stats / count metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/count',
                          'value' => 4,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / shards_total metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/shards/total',
                          'value' => 4,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / shards_primaries metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/shards/primaries',
                          'value' => 4,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / shards_replication metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/shards/replication',
                          'value' => 0.0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / shards_index_shards_min metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/shards/index/shards/min',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / shards_index_shards_max metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/shards/index/shards/max',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / shards_index_shards_avg metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/shards/index/shards/avg',
                          'value' => 1.0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / shards_index_primaries_min metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/shards/index/primaries/min',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / shards_index_primaries_max metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/shards/index/primaries/max',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / shards_index_primaries_avg metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/shards/index/primaries/avg',
                          'value' => 1.0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / shards_index_replication_min metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/shards/index/replication/min',
                          'value' => 0.0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / shards_index_replication_max metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/shards/index/replication/max',
                          'value' => 0.0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / shards_index_replication_avg metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/shards/index/replication/avg',
                          'value' => 0.0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / docs_count metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/docs/count',
                          'value' => 64,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / docs_deleted metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/docs/deleted',
                          'value' => 39,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / store_size_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/store/size_in_bytes',
                          'value' => 38_926_848,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / store_total_data_set_size_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/store/total_data_set_size_in_bytes',
                          'value' => 38_926_848,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / store_reserved_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/store/reserved_in_bytes',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / fielddata_memory_size_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/fielddata/memory_size_in_bytes',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / fielddata_evictions metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/fielddata/evictions',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / query_cache_memory_size_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/query_cache/memory_size_in_bytes',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / query_cache_total_count metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/query_cache/total_count',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / query_cache_hit_count metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/query_cache/hit_count',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / query_cache_miss_count metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/query_cache/miss_count',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / query_cache_cache_size metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/query_cache/cache_size',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / query_cache_cache_count metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/query_cache/cache_count',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / query_cache_evictions metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/query_cache/evictions',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / completion_size_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/completion/size_in_bytes',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / segments_count metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/segments/count',
                          'value' => 8,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / segments_memory_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/segments/memory_in_bytes',
                          'value' => 23_144,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / segments_terms_memory_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/segments/terms_memory_in_bytes',
                          'value' => 17_536,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / segments_stored_fields_memory_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/segments/stored_fields_memory_in_bytes',
                          'value' => 3952,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / segments_term_vectors_memory_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/segments/term_vectors_memory_in_bytes',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / segments_norms_memory_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/segments/norms_memory_in_bytes',
                          'value' => 448,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / segments_points_memory_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/segments/points_memory_in_bytes',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / segments_doc_values_memory_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/segments/doc_values_memory_in_bytes',
                          'value' => 1208,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / segments_index_writer_memory_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/segments/index_writer_memory_in_bytes',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / segments_version_map_memory_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/segments/version_map_memory_in_bytes',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / segments_fixed_bit_set_memory_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/segments/fixed_bit_set_memory_in_bytes',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / segments_max_unsafe_auto_id_timestamp metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'indices/segments/max_unsafe_auto_id_timestamp',
                          'value' => -1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end

  sub_test_case 'cluster_stats nodes metrics' do
    test 'it has cluster_stats nodes / count_total metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/total',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_coordinating_only metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/coordinating_only',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_data metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/data',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_data_cold metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/data_cold',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_data_content metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/data_content',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_data_frozen metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/data_frozen',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_data_hot metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/data_hot',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_data_warm metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/data_warm',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_ingest metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/ingest',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_master metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/master',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_ml metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/ml',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_remote_cluster_client metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/remote_cluster_client',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_transform metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/transform',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / count_voting_only metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/count/voting_only',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / os_available_processors metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/os/available_processors',
                          'value' => 16,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / os_allocated_processors metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/os/allocated_processors',
                          'value' => 16,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / os_mem_total_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/os/mem/total_in_bytes',
                          'value' => 32_366_751_744,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / os_mem_free_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/os/mem/free_in_bytes',
                          'value' => 1_339_219_968,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / os_mem_used_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/os/mem/used_in_bytes',
                          'value' => 31_027_531_776,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / os_mem_free_percent metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/os/mem/free_percent',
                          'value' => 4,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / os_mem_used_percent metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/os/mem/used_percent',
                          'value' => 96,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / process_cpu_percent metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/process/cpu/percent',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / process_open_file_descriptors_min metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/process/open_file_descriptors/min',
                          'value' => 341,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / process_open_file_descriptors_max metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/process/open_file_descriptors/max',
                          'value' => 341,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / process_open_file_descriptors_avg metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/process/open_file_descriptors/avg',
                          'value' => 341,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / jvm_max_uptime_in_millis metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/jvm/max_uptime_in_millis',
                          'value' => 3_443_443,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / jvm_mem_heap_used_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/jvm/mem/heap_used_in_bytes',
                          'value' => 1_252_947_160,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / jvm_mem_heap_max_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/jvm/mem/heap_max_in_bytes',
                          'value' => 16_190_013_440,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / jvm_threads metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/jvm/threads',
                          'value' => 72,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / fs_total_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/fs/total_in_bytes',
                          'value' => 927_155_486_720,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / fs_free_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/fs/free_in_bytes',
                          'value' => 552_200_962_048,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / fs_available_in_bytes metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/fs/available_in_bytes',
                          'value' => 552_200_962_048,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / network_types_transport_types_security4 metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/network_types/transport_types/security4',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / network_types_http_types_security4 metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/network_types/http_types/security4',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / discovery_types_zen metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/discovery_types/zen',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / ingest_number_of_pipelines metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/ingest/number_of_pipelines',
                          'value' => 1,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / ingest_processor_stats_gsub_count metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/ingest/processor_stats/gsub/count',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / ingest_processor_stats_gsub_failed metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/ingest/processor_stats/gsub/failed',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / ingest_processor_stats_gsub_current metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/ingest/processor_stats/gsub/current',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / ingest_processor_stats_gsub_time_in_millis metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/ingest/processor_stats/gsub/time_in_millis',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / ingest_processor_stats_script_count metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/ingest/processor_stats/script/count',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / ingest_processor_stats_script_failed metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/ingest/processor_stats/script/failed',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / ingest_processor_stats_script_current metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/ingest/processor_stats/script/current',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end

    test 'it has cluster_stats / ingest_processor_stats_script_time_in_millis metric' do
      data = create_data(data: fixture_json('cluster_stats'))
      expected_metric = { 'cluster_name' => 'elasticsearch',
                          'timestamp' => TEST_TIME_ISO,
                          'name' => 'nodes/ingest/processor_stats/script/time_in_millis',
                          'value' => 0,
                          'family' => 'cluster_stats' }
      metrics = data.extract_metrics
      assert metrics.include?(expected_metric)
    end
  end
end
