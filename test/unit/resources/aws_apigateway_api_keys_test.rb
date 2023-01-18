require 'helper'
require 'aws_apigateway_api_keys'
require 'aws-sdk-core'

class AWSApiGatewayAPIKeysConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayAPIKeys.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayAPIKeys.new('rubbish') }
  end

  def test_api_mapping_api_keys_non_existing_for_empty_response
    refute AWSApiGatewayAPIKeys.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSApiGatewayAPIKeysHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_api_keys
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:value] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:customer_id] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:enabled] = true
    mock_data[:created_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:last_updated_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:stage_keys] = ['test1']
    mock_data[:tags] = {}
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayAPIKeys.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ids
    assert_equal(@resp.ids, ['test1'])
  end

  def test_values
    assert_equal(@resp.values, ['test1'])
  end

  def test_names
    assert_equal(@resp.names, ['test1'])
  end

  def test_customer_ids
    assert_equal(@resp.customer_ids, ['test1'])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end

  def test_enabled
    assert_equal(@resp.enabled, [true])
  end

  def test_created_dates
    assert_equal(@resp.created_dates, [Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_last_updated_dates
    assert_equal(@resp.last_updated_dates, [Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_stage_keys
    assert_equal(@resp.stage_keys, [['test1']])
  end

  def test_tags
    assert_equal(@resp.tags, [{}])
  end
end
