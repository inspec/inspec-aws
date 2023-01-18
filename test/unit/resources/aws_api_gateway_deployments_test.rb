require 'helper'
require 'aws_api_gateway_deployments'
require 'aws-sdk-core'

class AWSApiGatewayDeploymentsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayDeployments.new(rest_api_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayDeployments.new('rubbish') }
  end

  def test_api_gateway_deployments_non_existing_for_empty_response
    refute AWSApiGatewayDeployments.new(rest_api_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSApiGatewayDeploymentsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_deployments
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:created_date] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @items = AWSApiGatewayDeployments.new(rest_api_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_work_groups_exists
    assert @items.exist?
  end

  def test_ids
    assert_equal(@items.ids, ['test1'])
  end

  def test_descriptions
    assert_equal(@items.descriptions, ['test1'])
  end

  def test_created_dates
    assert_equal(@items.created_dates, [Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end
end