require 'helper'
require 'aws_vpc_endpoint'
require 'aws-sdk-core'

class AwsVPCEndpointConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsVpce.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsVpce.new('rubbish') }
  end

  def test_accepts_vpc_endpoint_id_as_hash_eight_sign
    AwsVpce.new(vpc_endpoint_id: 'vpce-1234abcd', client_args: { stub_responses: true })
  end

  def test_accepts_vpc_endpoint_id_as_hash
    AwsVpce.new(vpc_endpoint_id: 'vpce-abcd123454321dcba', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsVpce.new(rubbish: 9) }
  end

  def test_rejects_invalid_vpc_endpoint_id
    assert_raises(ArgumentError) { AwsVpce.new(vpc_endpoint_id: 'vpce-rubbish') }
  end

  def test_vpc_endpoints_non_existing
    refute AwsVpce.new(vpc_endpoint_id: 'vpce-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsVpcEndpointHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_vpc_endpoints
    mock_vpc_endpoint = {}
    mock_vpc_endpoint[:vpc_endpoint_id] = 'vpce-1234567812345678a'
    mock_vpc_endpoint[:vpc_endpoint_type] = 'Gateway'
    mock_vpc_endpoint[:vpc_id] = 'vpc-abcdef123456abcde'
    mock_vpc_endpoint[:service_name] = 'com.amazonaws.us-west-2.s3'
    mock_vpc_endpoint[:state] = 'available'
    mock_vpc_endpoint[:route_table_ids] = ['rtb-1234456123456']
    mock_vpc_endpoint[:private_dns_enabled] = true
    data[:data] = { :vpc_endpoints => [mock_vpc_endpoint] }
    data[:client] = Aws::EC2::Client
    @vpce = AwsVpce.new(vpc_endpoint_id: 'vpce-1234567812345678a',client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpce_exists
    assert @vpce.exists?
  end

  def test_vpce_available
    assert @vpce.available?
  end

  def test_vpc_endpoint_id
    assert_equal(@vpce.vpc_endpoint_id, 'vpce-1234567812345678a')
  end

  def test_vpc_endpoint_type
    assert_equal(@vpce.vpc_endpoint_type, 'Gateway')
  end

  def test_vpc_id
    assert_equal(@vpce.vpc_id, 'vpc-abcdef123456abcde')
  end

  def test_service_name
    assert_equal(@vpce.service_name, 'com.amazonaws.us-west-2.s3')
  end

  def test_vpce_state
    assert_equal(@vpce.state, 'available')
    assert @vpce.available?
  end

  def test_vpce_route_table_ids
    assert_equal(@vpce.route_table_ids[0], 'rtb-1234456123456')
  end

  def test_vpce_private_dns_enabled
    assert_equal(@vpce.private_dns_enabled, true)
  end

  def test_resource_id
    refute_nil(@vpce.resource_id)
    assert_equal(@vpce.resource_id, @vpce.vpc_endpoint_id)
  end
end
