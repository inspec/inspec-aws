require 'helper'
require 'aws_apigateway_api_key'
require 'aws-sdk-core'

class AWSApiGatewayAPIKeyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayAPIKey.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayAPIKey.new(api_key: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayAPIKey.new(unexpected: 9) }
  end
end

class AWSApiGatewayAPIKeySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_api_key
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
    data[:data] = [mock_data]
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayAPIKey.new(api_key: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end

  def test_api_key_exists
    assert @resp.exists?
  end

  def test_id
    assert_equal(@resp.id, 'test1')
  end

  def test_value
    assert_equal(@resp.value, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_customer_id
    assert_equal(@resp.customer_id, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_enabled
    assert_equal(@resp.enabled, true)
  end

  def test_created_date
    assert_equal(@resp.created_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_last_updated_date
    assert_equal(@resp.last_updated_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_stage_keys
    assert_equal(@resp.stage_keys, ['test1'])
  end

  def test_tags
    assert_equal(@resp.tags, {})
  end
end
