# frozen_string_literal: true

require 'helper'
require 'fluent/plugin/elasticsearch_stats/cluster_health_data'

class ClusterHealthDataTest < Test::Unit::TestCase
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
    Fluent::Plugin::ElasticsearchStats::ClusterHealthData.new(
      data,
      **params
    )
  end

  def create_metric(**options)
    Fluent::Plugin::ElasticsearchStats::Metric.new(
      **options
    )
  end

  sub_test_case 'cluster health metrics' do
    sub_test_case 'cluster level' do
      test 'it has status metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/status',
                            'value' => 1,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }
        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end

      test 'it has number_of_nodes metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/number_of_nodes',
                            'value' => 1,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }
        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end

      test 'it has number_of_data_nodes metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/number_of_data_nodes',
                            'value' => 1,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }

        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end

      test 'it has active_primary_shards metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/active_primary_shards',
                            'value' => 4,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }
        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end

      test 'it has active_shards metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/active_shards',
                            'value' => 4,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }
        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end

      test 'it has relocating_shards metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/relocating_shards',
                            'value' => 0,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }
        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end

      test 'it has initializing_shards metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/initializing_shards',
                            'value' => 0,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }
        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end

      test 'it has unassigned_shards metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/unassigned_shards',
                            'value' => 0,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }
        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end

      test 'it has delayed_unassigned_shards metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/delayed_unassigned_shards',
                            'value' => 0,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }
        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end

      test 'it has number_of_pending_tasks metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/number_of_pending_tasks',
                            'value' => 0,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }
        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end

      test 'it has number_of_in_flight_fetch metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/number_of_in_flight_fetch',
                            'value' => 0,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }
        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end

      test 'it has task_max_waiting_in_queue_millis metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/task_max_waiting_in_queue_millis',
                            'value' => 0,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }
        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end

      test 'it has active_shards_percent_as_number metric' do
        data = create_data(data: fixture_json('cluster_health__with_indices'))
        expected_metric = {
                            'timestamp' => TEST_TIME_ISO,
                            'name' => 'cluster/active_shards_percent_as_number',
                            'value' => 100.0,
                            'family' => 'cluster_health',
                            'cluster_name' => 'elasticsearch' }
        metrics = data.send(:extract_cluster_metrics)
        assert metrics.include?(expected_metric)
      end
    end

    sub_test_case 'indices level' do
      sub_test_case 'without aggregation' do
        test 'it has status metric' do
          data = create_data(data: fixture_json('cluster_health__with_indices'))
          expected_metric = {
                              'index' => 'logs-000001',
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/status',
                              'value' => 1,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end
        test 'it has number_of_shards metric' do
          data = create_data(data: fixture_json('cluster_health__with_indices'))
          expected_metric = {
                              'index' => 'logs-000001',
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/number_of_shards',
                              'value' => 1,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end
        test 'it has number_of_replicas metric' do
          data = create_data(data: fixture_json('cluster_health__with_indices'))
          expected_metric = {
                              'index' => 'logs-000001',
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/number_of_replicas',
                              'value' => 0,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end
        test 'it has active_primary_shards metric' do
          data = create_data(data: fixture_json('cluster_health__with_indices'))
          expected_metric = {
                              'index' => 'logs-000001',
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/active_primary_shards',
                              'value' => 1,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end
        test 'it has active_shards metric' do
          data = create_data(data: fixture_json('cluster_health__with_indices'))
          expected_metric = {
                              'index' => 'logs-000001',
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/active_shards',
                              'value' => 1,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end
        test 'it has relocating_shards metric' do
          data = create_data(data: fixture_json('cluster_health__with_indices'))
          expected_metric = {
                              'index' => 'logs-000001',
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/relocating_shards',
                              'value' => 0,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end
        test 'it has initializing_shards metric' do
          data = create_data(data: fixture_json('cluster_health__with_indices'))
          expected_metric = {
                              'index' => 'logs-000001',
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/initializing_shards',
                              'value' => 0,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end
        test 'it has unassigned_shards metric' do
          data = create_data(data: fixture_json('cluster_health__with_indices'))
          expected_metric = {
                              'index' => 'logs-000001',
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/unassigned_shards',
                              'value' => 0,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end
      end

      sub_test_case 'with aggregation' do
        test 'it has active_shards metric' do
          metric = create_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
          data = create_data(data: fixture_json('cluster_health__with_indices'), metric: metric)
          expected_metric = {
                              'index' => 'logs-000001',
                              'index_base' => 'logs',
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/active_shards',
                              'value' => 1,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end

        test 'it has aggregated active_shards_count metric' do
          metric = create_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
          data = create_data(data: fixture_json('cluster_health__with_indices'), metric: metric)
          expected_metric = {
                              'index' => 'logs',
                              'index_base' => 'logs',
                              'aggregated' => true,
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/status/count',
                              'value' => 2,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end

        test 'it has aggregated active_shards_min metric' do
          metric = create_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
          data = create_data(data: fixture_json('cluster_health__with_indices'), metric: metric)
          expected_metric = {
                              'index' => 'logs',
                              'index_base' => 'logs',
                              'aggregated' => true,
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/active_shards/min',
                              'value' => 1,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end

        test 'it has aggregated active_shards_max metric' do
          metric = create_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
          data = create_data(data: fixture_json('cluster_health__with_indices'), metric: metric)
          expected_metric = {
                              'index' => 'logs',
                              'index_base' => 'logs',
                              'aggregated' => true,
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/active_shards/max',
                              'value' => 1,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end

        test 'it has aggregated active_shards_sum metric' do
          metric = create_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
          data = create_data(data: fixture_json('cluster_health__with_indices'), metric: metric)
          expected_metric = {
                              'index' => 'logs',
                              'index_base' => 'logs',
                              'aggregated' => true,
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/active_shards/sum',
                              'value' => 2,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end

        test 'it has aggregated active_shards_avg metric' do
          metric = create_metric(index_base_pattern: /(.+)-[0-9]{6}/, index_base_replacement: '\1')
          data = create_data(data: fixture_json('cluster_health__with_indices'), metric: metric)
          expected_metric = {
                              'index' => 'logs',
                              'index_base' => 'logs',
                              'aggregated' => true,
                              'timestamp' => TEST_TIME_ISO,
                              'name' => 'index/active_shards/avg',
                              'value' => 1.0,
                              'family' => 'cluster_health',
                              'cluster_name' => 'elasticsearch' }
          metrics = data.send(:extract_indices_metrics)
          assert metrics.include?(expected_metric)
        end
      end
    end
  end
end
