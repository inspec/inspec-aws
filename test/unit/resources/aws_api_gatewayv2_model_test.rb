require 'helper'
require 'aws_api_gatewayv2_model'
require 'aws-sdk-core'

class AWSApiGatewayV2ModelConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2Model.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2Model.new(api_id: '', model_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayV2Model.new(unexpected: 9) }
  end
end

class AWSApiGatewayV2ModelSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_model
    mock_data = {}
    mock_data[:content_type] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:model_id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:schema] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AWSApiGatewayV2Model.new(api_id: 'test1', model_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_model_exists
    assert @resp.exists?
  end

  def test_content_type
    assert_equal(@resp.content_type, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_model_id
    assert_equal(@resp.model_id, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_schema
    assert_equal(@resp.schema, 'test1')
  end
end
