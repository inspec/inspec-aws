require 'helper'
require 'aws_api_gateway_stages'
require 'aws-sdk-core'

class AWSApiGatewayStagesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayStages.new(rest_api_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayStages.new('rubbish') }
  end

  def test_api_gateway_stages_non_existing_for_empty_response
    refute AWSApiGatewayStages.new(rest_api_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSApiGatewayStagesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_stages
    mock_data = {}
    mock_data[:deployment_id] = 'test1'
    mock_data[:stage_name] = 'stage1'
    mock_data[:description] = 'test1'
    mock_data[:created_date] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] = { :item => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayStages.new(rest_api_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_stages_exists
    assert @resp.exist?
  end

  def test_deployment_ids
    assert_equal(@resp.deployment_ids, ['test1'])
  end

  def test_stage_names
    assert_equal(@resp.stage_names, ['stage1'])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end

  def test_created_dates
    assert_equal(@resp.created_dates, [Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end
end
