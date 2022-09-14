require 'helper'
require 'aws_api_gateway_v2_deployment'
require 'aws-sdk-core'

class AwsApiGatewayV2DeploymentConstructorTest < Minitest::Test
  
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2Deployment.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2Deployment.new(api_id: '',  deployment_id: '', client_args: { stub_responses: true }) }
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsApiGatewayV2Deployment.new(unexpected: 9) }
  end

  def test_unrecognized_identifiers
    assert_raises(ArgumentError) { AwsApiGatewayV2Deployment.new(random_id: 'random_id') }
  end
end

class AwsApiGatewayV2DeploymentSuccessPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_deployment
    mock_data = {}
    mock_data[:auto_deployed] = true
    mock_data[:created_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:deployment_id] = 'test_deployment_id'
    mock_data[:deployment_status] = 'DEPLOYED'
    mock_data[:deployment_status_message] = 'test_deployment_status_message'
    mock_data[:description] = 'test_description'
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2Deployment.new(api_id: 'test_api_id', deployment_id: 'test_deployment_id', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.deployment_id)
  end
  
  def test_deployment_exists
    assert @res.exists?
  end
  
  def test_auto_deployed
    assert_equal(@res.auto_deployed, true)
  end
  
  def test_created_date
    assert_equal(@res.created_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end
  
  def test_deployment_id
    assert_equal(@res.deployment_id, 'test_deployment_id')
  end
  
  def test_deployment_status
    assert_equal(@res.deployment_status, 'DEPLOYED')
  end
  
  def test_deployment_status_message
    assert_equal(@res.deployment_status_message, 'test_deployment_status_message')
  end
  
  def test_description
    assert_equal(@res.description, 'test_description')
  end
end
