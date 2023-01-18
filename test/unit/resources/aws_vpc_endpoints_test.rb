require 'helper'
require 'aws_vpc_endpoints'
require 'aws-sdk-core'

class AwsVPCEndpointsConstructorTest < Minitest::Test
  def test_empty_params_ok
    AwsVpces.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsVpces.new('rubbish') }
  end

  def test_vpc_endpoints_non_existing_for_empty_response
    refute AwsVpces.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsVpcEndpointsHappyPathTest < Minitest::Test

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
    @vpce = AwsVpces.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpce_exists
    assert @vpce.exists?
  end

  def test_vpc_endpoint_id
    assert_equal(@vpce.vpc_endpoint_ids, ['vpce-1234567812345678a'])
  end

  def test_vpc_endpoint_type
    assert_equal(@vpce.vpc_endpoint_types, ['Gateway'])
  end

  def test_vpc_id
    assert_equal(@vpce.vpc_ids, ['vpc-abcdef123456abcde'])
  end

  def test_service_name
    assert_equal(@vpce.service_names, ['com.amazonaws.us-west-2.s3'])
  end

  def test_vpce_state
    assert_equal(@vpce.states, ['available'])
  end

  def test_vpce_route_table_ids
    assert_equal(@vpce.route_table_ids, [['rtb-1234456123456']])
  end

  def test_vpce_private_dns_enabled
    assert_equal(@vpce.private_dns_enabled, [true])
  end

end