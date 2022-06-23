require 'helper'
require 'aws_api_gateway_resource'
require 'aws-sdk-core'

class AWSApiGatewayResourceConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayResource.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayResource.new(rest_api_id: '', resource_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayResource.new(unexpected: 9) }
  end
end

class AWSApiGatewayResourceSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_resource
    mock_data = {}
    mock_data[:id] = 'test_id'
    mock_data[:parent_id] = 'test_parent_id'
    mock_data[:path_part] = 'test_path_part'
    mock_data[:path] = 'test_path'
    mock_data[:resource_methods] = {}
    data[:data] = mock_data
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayResource.new(rest_api_id: 'test_rest_api_id', resource_id: 'test_resource_id', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, "#{@res.id}_#{@res.parent_id}")
  end

  def test_resource_exists
    assert @res.exists?
  end

  def test_id
    assert_equal(@res.id, 'test_id')
  end

  def test_parent_id
    assert_equal(@res.parent_id, 'test_parent_id')
  end

  def test_path_part
    assert_equal(@res.path_part, 'test_path_part')
  end

  def test_path
    assert_equal(@res.path, 'test_path')
  end
  
  def test_resource_methods
    assert_equal(@res.resource_methods, {})
  end
end
