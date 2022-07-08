require 'helper'
require 'aws_api_gateway_v2_deployments'
require 'aws-sdk-core'

class AwsApiGatewayV2DeploymentsConstructorTest < Minitest::Test
  
  def test_empty_params_ok
    AwsApiGatewayV2Deployments.new(api_id: 'test_api_id', client_args: { stub_responses: true })
  end
end

class AwsApiGatewayV2DeploymentsHappyPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_deployments
    mock_data = {}
    mock_data[:auto_deployed] = true
    mock_data[:created_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:deployment_id] = 'test_deployment_id'
    mock_data[:deployment_status] = 'DEPLOYED'
    mock_data[:deployment_status_message] = 'test_deployment_status_message'
    mock_data[:description] = 'test_description'
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2Deployments.new(api_id: 'test_api_id', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_deployments_exists
    assert @res.exists?
  end

  def test_auto_deployeds
    assert_equal(@res.auto_deployeds, [true])
  end

  def test_created_dates
    assert_equal(@res.created_dates, [Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_deployment_ids
    assert_equal(@res.deployment_ids, ['test_deployment_id'])
  end

  def test_deployment_statuses
    assert_equal(@res.deployment_statuses, ['DEPLOYED'])
  end

  def test_deployment_status_messages
    assert_equal(@res.deployment_status_messages, ['test_deployment_status_message'])
  end

  def test_descriptions
    assert_equal(@res.descriptions, ['test_description'])
  end
end
