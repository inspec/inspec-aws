require 'helper'
require 'aws_api_gateway_usage_plans'
require 'aws-sdk-core'

class AWSApiGatewayUsagePlansConstructorTest < Minitest::Test

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayUsagePlans.new(unexpected: 9) }
  end
end

class AWSApiGatewayUsagePlansSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_usage_plans
    mock_data = {}
    mock_data[:id] = 'test'
    mock_data[:name] = 'test'
    mock_data[:description] = 'test'
    mock_data[:api_stages] = []
    mock_data[:throttle] = {}
    mock_data[:quota] = {
      limit: 1,
      offset: 1,
      period: 'test'
    }
    mock_data[:product_code] = 'test'
    mock_data[:tags] = {}
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayUsagePlans.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_usage_plans_exists
    assert @res.exists?
  end

  def test_ids
    assert_equal(@res.ids, ['test'])
  end

  def test_names
    assert_equal(@res.names, ['test'])
  end

  def test_descriptions
    assert_equal(@res.descriptions, ['test'])
  end

  def test_product_codes
    assert_equal(@res.product_codes, ['test'])
  end

  def test_tags
    assert_equal(@res.tags, [{}])
  end
end
