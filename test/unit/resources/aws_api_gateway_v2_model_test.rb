require 'helper'
require 'aws_api_gateway_v2_model'
require 'aws-sdk-core'

class AwsApiGatewayV2ModelConstructorTest < Minitest::Test
  
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2Model.new(client_args: { stub_responses: true }) }
  end
  
  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) do  AwsApiGatewayV2Model.new(api_id: '', model_id: '', client_args: { stub_responses: true })
    end
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsApiGatewayV2Model.new(unexpected: 9) }
  end
end

class AwsApiGatewayV2ModelSuccessPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_model
    mock_data = {}
    mock_data[:content_type] = 'test_content_type'
    mock_data[:description] = 'test_description'
    mock_data[:model_id] = 'test_model_id'
    mock_data[:name] = 'test_name'
    mock_data[:schema] = 'test_schema'
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2Model.new(api_id: 'APP_ID', model_id: 'MODEL_ID', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.model_id)
  end
  
  def test_model_exists
    assert @res.exists?
  end

  def test_content_type
    assert_equal(@res.content_type, 'test_content_type')
  end

  def test_description
    assert_equal(@res.description, 'test_description')
  end

  def test_model_id
    assert_equal(@res.model_id, 'test_model_id')
  end

  def test_name
    assert_equal(@res.name, 'test_name')
  end

  def test_schema
    assert_equal(@res.schema, 'test_schema')
  end
end
