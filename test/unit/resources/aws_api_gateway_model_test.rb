require 'helper'
require 'aws_api_gateway_model'
require 'aws-sdk-core'

class AWSApiGatewayModelConstructorTest < Minitest::Test

  # def test_empty_params_not_ok
  #   assert_raises(ArgumentError) { AWSApiGatewayModel.new(client_args: { stub_responses: true }) }
  # end

  def test_params_ok
    AWSApiGatewayModel.new(rest_api_id: 'test1', model_name: 'test1', client_args: { stub_responses: true })
  end

  # def test_rejects_other_args
  #   assert_raises(ArgumentError) { AWSApiGatewayModel.new('rubbish') }
  # end
end

class AWSApiGatewayModelHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_model
    mock_data = {}
    mock_data[:content_type] = 'test'
    mock_data[:description] = 'test'
    mock_data[:model_id] = 'test'
    mock_data[:name] = 'test'
    mock_data[:schema] = 'test'
    data[:data] = [mock_data]
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayModel.new(rest_api_id: 'test', model_name: 'test' , client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_model_exists
    assert @resp.exist?
  end

  def test_model_name
    assert_equal(@resp.model_id, 'test')
  end

  def test_content_type
    assert_equal(@resp.content_type, 'test')
  end

  def test_name
    assert_equal(@resp.name, 'test')
  end

  def test_schema
    assert_equal(@resp.schema, 'test')
  end

end 
