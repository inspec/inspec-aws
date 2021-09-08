require 'helper'
require 'aws_api_gatewayv2_deployment'
require 'aws-sdk-core'

class AWSApiGatewayV2DeploymentConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2Deployment.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2Deployment.new(api_id: '', deployment_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayV2Deployment.new(unexpected: 9) }
  end
end

class AWSApiGatewayV2DeploymentSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_deployment
    mock_data = {}
    mock_data[:auto_deployed] = true
    mock_data[:created_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:deployment_id] = 'test1'
    mock_data[:deployment_status] = 'test1'
    mock_data[:deployment_status_message] = 'test1'
    mock_data[:description] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AWSApiGatewayV2Deployment.new(api_id: 'test1', deployment_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_api_exists
    assert @resp.exists?
  end

  def test_auto_deployed
    assert_equal(@resp.auto_deployed, true)
  end

  def test_created_date
    assert_equal(@resp.created_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_deployment_id
    assert_equal(@resp.deployment_id, 'test1')
  end

  def test_deployment_status
    assert_equal(@resp.deployment_status, 'test1')
  end

  def test_deployment_status_message
    assert_equal(@resp.deployment_status_message, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end
end
