# frozen_string_literal: true

require 'helper'
require 'fluent/plugin/in_elasticsearch_stats'

class ElasticsearchStatsInputTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  sub_test_case 'configuration' do
    test 'default configuration' do
      driver = create_driver
      input = driver.instance

      assert_equal Fluent::Plugin::ElasticsearchStatsInput::DEFAULT_TAG, input.tag
      assert_equal Fluent::Plugin::ElasticsearchStatsInput::DEFAULT_URLS, input.urls
      assert_equal Fluent::Plugin::ElasticsearchStatsInput::DEFAULT_TIMEOUT, input.timeout
      assert_equal Fluent::Plugin::ElasticsearchStatsInput::DEFAULT_USER_AGENT, input.user_agent

      assert_equal Fluent::Plugin::ElasticsearchStatsInput::DEFAULT_INTERVAL, input.interval
      # assert_equal Fluent::Plugin::KafkaStatusInput::DEFAULT_CLIENT_ID, input.client_id
      # assert_equal Fluent::Plugin::KafkaStatusInput::DEFAULT_BROKERS, input.brokers
      # assert_equal Fluent::Plugin::KafkaStatusInput::DEFAULT_INTERVAL, input.interval
      # assert_equal Fluent::Plugin::KafkaStatusInput::DEFAULT_TIMESTAMP_FORMAT, input.timestamp_format
      # assert_equal Fluent::Plugin::KafkaStatusInput::DEFAULT_EVENT_PREFIX, input.event_prefix
      # assert_equal nil, input.connect_timeout
      # assert_equal nil, input.ssl_ca_cert
      # assert_equal nil, input.ssl_client_cert
      # assert_equal nil, input.ssl_client_cert_key
      # assert_equal true, input.ssl_verify_hostname

      assert_equal nil, input.username
      assert_equal nil, input.password
      assert_equal nil, input.ca_file
      assert_equal true, input.verify_ssl

      assert_equal Fluent::Plugin::ElasticsearchStatsInput::DEFAULT_CLUSTER_HEALTH, input.cluster_health
      assert_equal Fluent::Plugin::ElasticsearchStatsInput::DEFAULT_CLUSTER_HEALTH_LEVEL, input.cluster_health_level
      assert_equal Fluent::Plugin::ElasticsearchStatsInput::DEFAULT_CLUSTER_HEALTH_LOCAL, input.cluster_health_local
    end

    test 'tag should not be empty' do
      conf = %(
        #{BASE_CONF}
        tag ""
      )
      assert_raise(Fluent::ConfigError) do
        create_driver(conf)
      end
    end

    test 'urls should not be empty' do
      conf = %(
        #{BASE_CONF}
        urls ""
      )
      assert_raise(Fluent::ConfigError) do
        create_driver(conf)
      end
    end
  end

  private

  BASE_CONF = %()
  def create_driver(conf = BASE_CONF)
    Fluent::Test::Driver::Input.new(Fluent::Plugin::ElasticsearchStatsInput).configure(conf)
  end

  MOCKED_TIME = Time.parse('2024-01-01T00:00:00.000Z')
end
