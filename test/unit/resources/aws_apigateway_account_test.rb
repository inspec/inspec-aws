require 'helper'
require 'aws_apigateway_account'
require 'aws-sdk-core'

class AWSApiGatewayAccountConstructorTest < Minitest::Test

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayAccount.new(unexpected: 9) }
  end
end

class AWSApiGatewayAccountSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_account
    mock_data = {}
    mock_data[:cloudwatch_role_arn] = 'test1'
    mock_data[:throttle_settings] = {
      burst_limit: 1,
      rate_limit: 1.0
    }
    mock_data[:features] = ['test1']
    mock_data[:api_key_version] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayAccount.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end

  def test_account_exists
    assert @resp.exists?
  end

  def test_cloudwatch_role_arn
    assert_equal(@resp.cloudwatch_role_arn, 'test1')
  end

  def test_burst_limit
    assert_equal(@resp.throttle_settings.burst_limit, 1)
  end

  def test_features
    assert_equal(@resp.features, ['test1'])
  end

  def test_api_key_version
    assert_equal(@resp.api_key_version, 'test1')
  end
end
