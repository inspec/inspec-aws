require 'helper'
require 'aws_api_gateway_method'
require 'aws-sdk-core'

class AWSApiGatewayMethodConstructorTest < Minitest::Test

	def test_empty_params_not_ok
		assert_raises(ArgumentError) { AWSApiGatewayMethod.new(client_args: { stub_responses: true }) }
	end

	def test_empty_param_arg_not_ok
		assert_raises(ArgumentError) { AWSApiGatewayMethod.new(rest_api_id: '', resource_id: '', http_method: '', client_args: { stub_responses: true }) }
	end

	def test_rejects_unrecognized_params
		assert_raises(ArgumentError) { AWSApiGatewayMethod.new(unexpected: 9) }
	end
end

class AWSApiGatewayMethodSuccessPathTest < Minitest::Test

	def setup
		data = {}
		data[:method] = :get_method
		mock_data = {}
		mock_data[:http_method] = 'test1'
		mock_data[:authorization_type] = 'test1'
    mock_data[:authorizer_id] = 'test1'
    mock_data[:api_key_required] = true
    mock_data[:request_validator_id] = 'test1'
    mock_data[:operation_name] = 'test1'
    mock_data[:request_parameters] = {}
    mock_data[:request_models] = {}
    mock_data[:method_responses] = {}
		data[:data] = [mock_data]
		data[:client] = Aws::APIGateway::Client
		@res = AWSApiGatewayMethod.new(rest_api_id: 'test1', resource_id: 'test1', http_method: 'test1', client_args: { stub_responses: true }, stub_data: [data])
	end

  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, 'test1_test1')
  end

	def test_api_gateway_method_exists
		assert @res.exists?
	end

	def test_http_method
		assert_equal(@res.http_method, 'test1')
	end

	def test_authorization_type
		assert_equal(@res.authorization_type, 'test1')
	end

  def test_authorizer_id
    assert_equal(@res.authorizer_id, 'test1')
  end

  def test_api_key_required
    assert_equal(@res.api_key_required, true)
  end

  def test_request_validator_id
    assert_equal(@res.request_validator_id, 'test1')
  end

  def test_operation_name
    assert_equal(@res.operation_name, 'test1')
  end

  def test_request_parameters
    assert_equal(@res.request_parameters, {})
  end

  def test_request_models
    assert_equal(@res.request_models, {})
  end

  def test_method_responses
    assert_equal(@res.method_responses, {})
  end
end