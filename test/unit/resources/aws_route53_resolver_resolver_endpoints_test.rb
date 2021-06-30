require 'helper'
require 'aws_route53resolver_resolver_endpoints'
require 'aws-sdk-core'

class AWSRoute53ResolverResolverEndpointsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSRoute53ResolverResolverEndpoints.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSRoute53ResolverResolverEndpoints.new('rubbish') }
  end

  def test_functions_non_existing_for_empty_response
    refute AWSRoute53ResolverResolverEndpoints.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSRoute53ResolverResolverEndpointsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_resolver_endpoints
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
    data[:data] = { :resolver_endpoints => [mock_data] }
    data[:client] = Aws::Route53Resolver::Client
    @resolver_endpoints = AWSRoute53ResolverResolverEndpoints.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resolver_endpoints_exists
    assert @resolver_endpoints.exists?
  end

  def test_ids
    assert_equal(@resolver_endpoints.ids, ['test1'])
  end

  def test_creator_request_ids
    assert_equal(@resolver_endpoints.creator_request_ids, ['test1'])
  end

  def test_arns
    assert_equal(@resolver_endpoints.arns, ['test1'])
  end

  def test_names
    assert_equal(@resolver_endpoints.names, ['test1'])
  end

  def test_security_group_ids
    assert_equal(@resolver_endpoints.security_group_ids, [[]])
  end

  def test_directions
    assert_equal(@resolver_endpoints.directions, ['test1'])
  end

  def test_ip_address_counts
    assert_equal(@resolver_endpoints.ip_address_counts, [1])
  end

  def test_host_vpc_ids
    assert_equal(@resolver_endpoints.host_vpc_ids, ['test1'])
  end

  def test_statuses
    assert_equal(@resolver_endpoints.statuses, ['test1'])
  end

  def test_status_messages
    assert_equal(@resolver_endpoints.status_messages, ['test1'])
  end

  def test_creation_times
    assert_equal(@resolver_endpoints.creation_times, ['test1'])
  end

  def test_modification_times
    assert_equal(@resolver_endpoints.modification_times, ['test1'])
  end
end