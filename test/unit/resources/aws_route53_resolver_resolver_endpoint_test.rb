require 'helper'
require 'aws_route53resolver_resolver_endpoint'
require 'aws-sdk-core'

class AWSRoute53ResolverResolverEndpointConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRoute53ResolverResolverEndpoint.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRoute53ResolverResolverEndpoint.new(resolver_endpoint_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRoute53ResolverResolverEndpoint.new(unexpected: 9) }
  end
end

class AWSRoute53ResolverResolverEndpointSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_resolver_endpoint
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:creator_request_id] = 'test1'
    mock_data[:arn] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:security_group_ids] = []
    mock_data[:direction] = 'test1'
    mock_data[:ip_address_count] = 1
    mock_data[:host_vpc_id] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:status_message] = 'test1'
    mock_data[:creation_time] = 'test1'
    mock_data[:modification_time] = 'test1'
    data[:data] = { resolver_endpoint: mock_data }
    data[:client] = Aws::Route53Resolver::Client
    @resolver_endpoint = AWSRoute53ResolverResolverEndpoint.new(resolver_endpoint_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_endpoint_exists
    assert @resolver_endpoint.exists?
  end

  def test_id
    assert_equal(@resolver_endpoint.id, 'test1')
  end

  def test_creator_request_id
    assert_equal(@resolver_endpoint.creator_request_id, 'test1')
  end

  def test_arn
    assert_equal(@resolver_endpoint.arn, 'test1')
  end

  def test_name
    assert_equal(@resolver_endpoint.name, 'test1')
  end

  def test_security_group_ids
    assert_equal(@resolver_endpoint.security_group_ids, [])
  end

  def test_direction
    assert_equal(@resolver_endpoint.direction, 'test1')
  end

  def test_ip_address_count
    assert_equal(@resolver_endpoint.ip_address_count, 1)
  end

  def test_host_vpc_id
    assert_equal(@resolver_endpoint.host_vpc_id, 'test1')
  end

  def test_status
    assert_equal(@resolver_endpoint.status, 'test1')
  end

  def test_status_message
    assert_equal(@resolver_endpoint.status_message, 'test1')
  end

  def test_creation_time
    assert_equal(@resolver_endpoint.creation_time, 'test1')
  end

  def test_modification_time
    assert_equal(@resolver_endpoint.modification_time, 'test1')
  end
end