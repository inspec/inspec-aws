require 'helper'
require 'aws_api_gateway_usage_plan_keys'
require 'aws-sdk-core'

class AWSApiGatewayUsagePlanKeysConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayUsagePlanKeys.new(usage_plan_id: '', client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayUsagePlanKeys.new(usage_plan_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayUsagePlanKeys.new(unexpected: 9) }
  end
end

class AWSApiGatewayUsagePlanKeysSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_usage_plan_keys
    mock_data = {}
    mock_data[:id] = 'KEY_ID'
    mock_data[:type] = 'KEY_TYPE'
    mock_data[:value] = 'KEY_VALUE'
    mock_data[:name] = 'KEY_NAME'
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayUsagePlanKeys.new(usage_plan_id: 'PLAN_KEY_ID', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_usage_plan_keys_exists
    assert @res.exists?
  end

  def test_ids
    assert_equal(@res.ids, ['KEY_ID'])
  end

  def test_types
    assert_equal(@res.types, ['KEY_TYPE'])
  end

  def test_values
    assert_equal(@res.values, ['KEY_VALUE'])
  end

  def test_names
    assert_equal(@res.names, ['KEY_NAME'])
  end
end
