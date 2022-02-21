require 'helper'
require 'aws_api_gateway_response'
require 'aws-sdk-core'

class AWSApiGatewayResponseConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayResponse.new(rest_api_id: '', response_type: '', client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayResponse.new(rest_api_id: '', response_type: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayResponse.new(unexpected: 9) }
  end
end

class AWSApiGatewayResponseHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_gateway_response
    mock_data = {}
    mock_data[:response_type] = 'test'
    mock_data[:status_code] = 'test'
    mock_data[:response_parameters] = {"String" => 'test'}
    mock_data[:response_templates] = {"String" => 'test'}
    mock_data[:default_response] = true
    data[:data] = mock_data
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayResponse.new(rest_api_id: 'test', response_type: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_response_exists
    assert @resp.exist?
  end

  def test_response_type
    assert_equal(@resp.response_type, 'test')
  end

  def test_status_code
    assert_equal(@resp.status_code, 'test')
  end

  def test_default_response
    assert_equal(@resp.default_response, true )
  end
end
