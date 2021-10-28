require 'helper'
require 'aws_ec2_client_vpn_endpoint'
require 'aws-sdk-core'

class AWSEC2ClientVPNEndpointConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2ClientVPNEndpoint.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_client_vpn_endpoint_id_as_hash_eight_sign
    AWSEC2ClientVPNEndpoint.new(client_vpn_endpoint_id: 'test', client_args: { stub_responses: true })
  end

  def test_accepts_client_vpn_endpoint_id_as_hash
    AWSEC2ClientVPNEndpoint.new(client_vpn_endpoint_id: 'test', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2ClientVPNEndpoint.new(rubbish: 9) }
  end
end

class AWSEC2ClientVPNEndpointPathTest < Minitest::Test
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
    @resp = AWSEC2ClientVPNEndpoint.new(client_vpn_endpoint_id: "test", client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_client_vpn_endpoint_id_exists
    assert @resp.exists?
  end

  def test_client_vpn_endpoint_id_available
    assert @resp.available?
  end

  def test_client_vpn_endpoint_id
    assert_equal(@resp.client_vpn_endpoint_id, 'test')
  end

  def test_description
    assert_equal(@resp.description, 'test')
  end

  def test_dns_name
    assert_equal(@resp.dns_name, 'test')
  end

  def test_client_cidr_block
    assert_equal(@resp.client_cidr_block, 'test')
  end

  def test_dns_servers
    assert_equal(@resp.dns_servers, ["vpc"])
  end

  def test_split_tunnel
    assert_equal(@resp.split_tunnel, true)
  end
end
