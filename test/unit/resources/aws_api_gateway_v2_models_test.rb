require 'helper'
require 'aws_api_gateway_v2_models'
require 'aws-sdk-core'

class AwsApiGatewayV2ModelsConstructorTest < Minitest::Test
  
  def test_empty_params_ok
    AwsApiGatewayV2Models.new(api_id: 'test_api_id', client_args: { stub_responses: true })
  end
end

class AwsApiGatewayV2ModelsHappyPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_models
    mock_data = {}
    mock_data[:content_type] = 'test_content_type'
    mock_data[:description] = 'test_description'
    mock_data[:model_id] = 'test_model_id'
    mock_data[:name] = 'test_name'
    mock_data[:schema] = 'test_schema'
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2Models.new(api_id: 'test_api_id', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_models_exists
    assert @res.exists?
  end

  def test_content_types
    assert_equal(@res.content_types, ['test_content_type'])
  end

  def test_descriptions
    assert_equal(@res.descriptions, ['test_description'])
  end

  def test_model_ids
    assert_equal(@res.model_ids, ['test_model_id'])
  end

  def test_names
    assert_equal(@res.names, ['test_name'])
  end

  def test_schemas
    assert_equal(@res.schemas, ['test_schema'])
  end
end
