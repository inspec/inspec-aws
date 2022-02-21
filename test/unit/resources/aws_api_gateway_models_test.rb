require 'helper'
require 'aws_api_gateway_models'
require 'aws-sdk-core'

class AWSApiGatewayModelsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayModels.new(rest_api_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayModels.new('rubbish') }
  end

  def test_models_non_existing_for_empty_response
    refute AWSApiGatewayModels.new(rest_api_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSApiGatewayModelsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_models
    mock_data = {}
    mock_data[:content_type] = 'test'
    mock_data[:description] = 'test'
    mock_data[:model_id] = 'test'
    mock_data[:name] = 'test'
    mock_data[:schema] = 'test'
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayModels.new(rest_api_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_models_exists
    assert @resp.exist?
  end

  def test_model_ids
    assert_equal(@resp.model_ids, 'test')
  end

  def test_content_types
    assert_equal(@resp.content_types, 'test')
  end

  def test_names
    assert_equal(@resp.names, 'test')
  end

  def test_schemas
    assert_equal(@resp.schemas, 'test')
  end

end
