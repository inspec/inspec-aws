require 'helper'
require 'aws_api_gateway_responses'
require 'aws-sdk-core'

class AWSApiGatewayResponsesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayResponses.new(rest_api_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayResponses.new('rubbish') }
  end

  def test_api_gateway_responses_non_existing_for_empty_response
    refute AWSApiGatewayResponses.new(rest_api_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSApiGatewayResponsesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_gateway_responses
    mock_data = {}
    mock_data[:response_type] = 'test'
    mock_data[:status_code] = 'test'
    mock_data[:response_parameters] = {"String" => 'test'}
    mock_data[:response_templates] = {"String" => 'test'}
    mock_data[:default_response] = true
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayResponses.new(rest_api_id: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_response_exists
    assert @resp.exist?
  end

  def test_response_types
    assert_equal(@resp.response_types, ['test'])
  end

  def test_status_codes
    assert_equal(@resp.status_codes, ['test'])
  end

  def test_default_responses
    assert_equal(@resp.default_responses, [true])
  end
end
