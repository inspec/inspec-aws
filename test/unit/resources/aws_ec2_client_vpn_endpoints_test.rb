require 'helper'
require 'aws_ec2_client_vpn_endpoints'
require 'aws-sdk-core'

class AWSEC2ClientVPNEndpointsConstructorTest < Minitest::Test
  def test_empty_params_ok
    AWSEC2ClientVPNEndpoints.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2ClientVPNEndpoints.new('rubbish') }
  end

  def test_client_vpn_endpoints_non_existing_for_empty_response
    refute AWSEC2ClientVPNEndpoints.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2ClientVPNEndpointsPathTest < Minitest::Test
def setup
  data = {}
  data[:method] = :describe_client_vpn_endpoints
  mock_data = {}
  mock_data[:client_vpn_endpoint_id] = "test"
  mock_data[:description] = 'test'
  mock_data[:dns_name] = 'test'
  mock_data[:client_cidr_block] = 'test'
  mock_data[:dns_servers] = ['vpc']
  mock_data[:split_tunnel] = true
  data[:data] = { client_vpn_endpoints: [mock_data] }
  data[:client] = Aws::EC2::Client
  @resp = AWSEC2ClientVPNEndpoints.new(client_args: { stub_responses: true }, stub_data: [data])
end

def test_client_vpn_endpoint_id_exists
  assert @resp.exists?
end

def test_client_vpn_endpoint_id_available
  assert @resp.available?
end

def test_client_vpn_endpoint_id
  assert_equal(@resp.client_vpn_endpoint_ids, ['test'])
end

def test_description
  assert_equal(@resp.descriptions, ['test'])
end

def test_dns_name
  assert_equal(@resp.dns_names, ['test'])
end

def test_split_tunnel
  assert_equal(@resp.split_tunnels, [true])
end
end
