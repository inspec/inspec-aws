require 'helper'
require 'aws_api_gateway_model'
require 'aws-sdk-core'

class AWSApiGatewayModelConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayModel.new(rest_api_id: '', model_name: '', client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayModel.new(rest_api_id: '', model_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayModel.new(unexpected: 9) }
  end
end

class AWSApiGatewayModelHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_model
    mock_data = {}
    mock_data[:id] = 'test'
    mock_data[:name] = 'test'
    mock_data[:description] = 'test'
    mock_data[:content_type] = 'test'
    mock_data[:schema] = 'test'
    data[:data] = mock_data
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayModel.new(rest_api_id: 'test', model_name: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test')
  end

  def test_model_exists
    assert @resp.exist?
  end

  def test_id
    assert_equal(@resp.id, 'test')
  end

  def test_name
    assert_equal(@resp.name, 'test')
  end

  def test_description
    assert_equal(@resp.description, 'test')
  end

  def test_content_type
    assert_equal(@resp.content_type, 'test')
  end

  def test_schema
    assert_equal(@resp.schema, 'test')
  end
end
