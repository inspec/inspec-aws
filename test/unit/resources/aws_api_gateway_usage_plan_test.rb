require 'helper'
require 'aws_api_gateway_usage_plan'
require 'aws-sdk-core'

class AWSApiGatewayUsagePlanConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayUsagePlan.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayUsagePlan.new(usage_plan_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayUsagePlan.new(unexpected: 9) }
  end
end

class AWSApiGatewayUsagePlanSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_usage_plan
    mock_data = {}
    mock_data[:id] = 'test'
    mock_data[:name] = 'test'
    mock_data[:description] = 'test'
    mock_data[:api_stages] = [
      api_id: 'test',
      stage: 'test'
    ]
    mock_data[:quota] = {
      limit: 1,
      offset: 1,
      period: 'test'
    }
    mock_data[:product_code] = 'test'
    mock_data[:tags] = {}
    data[:data] = [mock_data]
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayUsagePlan.new(usage_plan_id: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.id)
  end

  def test_usage_plan_exists
    assert @res.exists?
  end

  def test_id
    assert_equal(@res.id, 'test')
  end

  def test_name
    assert_equal(@res.name, 'test')
  end

  def test_description
    assert_equal(@res.description, 'test')
  end

  def test_quota_limit
    assert_equal(@res.quota.limit, 1)
  end

  def test_quota_offset
    assert_equal(@res.quota.offset, 1.0)
  end

  def test_quota_period
    assert_equal(@res.quota.period, 'test')
  end

  def test_product_code
    assert_equal(@res.product_code, 'test')
  end

  def test_tags
    assert_equal(@res.tags, {})
  end
end
