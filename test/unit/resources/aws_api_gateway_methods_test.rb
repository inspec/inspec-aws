require 'helper'
require 'aws_api_gateway_methods'
require 'aws-sdk-core'

class AWSApiGatewayMethodsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayMethods.new(rest_api_id: 'test1', resource_id: 'test1', http_method: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayMethods.new('rubbish') }
  end
end

class AWSApiGatewayMethodsHappyPathTest < Minitest::Test

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
    @res = AWSApiGatewayMethods.new(rest_api_id: 'test1', resource_id: 'test1', http_method: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_items_exists
    assert @res.exist?
  end

  def test_http_methods
    assert_equal(@res.http_methods, ['test1'])
  end

  def test_authorization_types
    assert_equal(@res.authorization_types, ['test1'])
  end

  def test_authorizer_ids
    assert_equal(@res.authorizer_ids, ['test1'])
  end

  def test_api_key_required
    assert_equal(@res.api_key_required, [true])
  end

  def test_request_validator_ids
    assert_equal(@res.request_validator_ids, ['test1'])
  end

  def test_operation_names
    assert_equal(@res.operation_names, ['test1'])
  end

  def test_request_parameters
    assert_equal(@res.request_parameters, [{}])
  end

  def test_request_models
    assert_equal(@res.request_models, [{}])
  end

  def test_method_responses
    assert_equal(@res.method_responses, [{}])
  end
end