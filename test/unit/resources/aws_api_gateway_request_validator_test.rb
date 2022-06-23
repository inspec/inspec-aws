require 'helper'
require 'aws_api_gateway_request_validator'
require 'aws-sdk-core'

class AWSApiGatewayRequestValidatorConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayRequestValidator.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayRequestValidator.new(rest_api_id: '', request_validator_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayRequestValidator.new(unexpected: 9) }
  end
end

class AWSApiGatewayRequestValidatorSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_request_validator
    mock_data = {}
    mock_data[:id] = 'test'
    mock_data[:name] = 'test'
    mock_data[:validate_request_body] = true
    mock_data[:validate_request_parameters] = true
    data[:data] = [mock_data]
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayRequestValidator.new(rest_api_id: 'test', request_validator_id: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, 'test')
  end

  def test_request_validator_exists
    assert @res.exists?
  end

  def test_id
    assert_equal(@res.id, 'test')
  end

  def test_name
    assert_equal(@res.name, 'test')
  end

  def test_validate_request_body
    assert_equal(@res.validate_request_body, true)
  end

  def test_validate_request_parameters
    assert_equal(@res.validate_request_parameters, true)
  end
end