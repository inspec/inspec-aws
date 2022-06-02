require 'helper'
require 'aws_api_gateway_usage_plan_key'
require 'aws-sdk-core'

class AWSApiGatewayUsagePlanKeyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayUsagePlanKey.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayUsagePlanKey.new(usage_plan_id: '', key_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayUsagePlanKey.new(unexpected: 9) }
  end
end

class AWSApiGatewayUsagePlanKeySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_usage_plan_key
    mock_data = {}
    mock_data[:id] = 'KEY_ID'
    mock_data[:type] = 'KEY_TYPE'
    mock_data[:value] = 'KEY_VALUE'
    mock_data[:name] = 'KEY_NAME'
    data[:data] = [mock_data]
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayUsagePlanKey.new(usage_plan_id: 'PLAN_KEY_ID', key_id: 'KEY_ID', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.id+'_'+@res.name)
  end

  def test_usage_plan_key_exists
    assert @res.exists?
  end

  def test_id
    assert_equal(@res.id, 'KEY_ID')
  end

  def test_type
    assert_equal(@res.type, 'KEY_TYPE')
  end

  def test_value
    assert_equal(@res.value, 'KEY_VALUE')
  end

  def test_name
    assert_equal(@res.name, 'KEY_NAME')
  end
end
