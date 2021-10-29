require 'helper'
require 'aws_ec2_client_vpn_target_network_association'
require 'aws-sdk-core'

class AWSEC2ClientVPNTargetNetworkAssociationConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2ClientVPNTargetNetworkAssociation.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_vpc_endpoint_id_association_id_as_hash_eight_sign
    AWSEC2ClientVPNTargetNetworkAssociation.new(client_vpn_endpoint_id: 'test', association_id: 'test', client_args: { stub_responses: true })
  end

  def test_accepts_vpc_endpoint_id_association_id_as_hash
    AWSEC2ClientVPNTargetNetworkAssociation.new(client_vpn_endpoint_id: 'test', association_id: 'test', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2ClientVPNTargetNetworkAssociation.new(rubbish: 9) }
  end
end

class AWSEC2ClientVPNTargetNetworkAssociationPathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_client_vpn_target_networks
    mock_data = {}
    mock_data[:client_vpn_endpoint_id] = "test"
    mock_data[:association_id] = 'test'
    mock_data[:vpc_id] = 'test'
    mock_data[:status] = { code: "test", message: "test" }
    mock_data[:security_groups] = ["sg-1"]
    mock_data[:target_network_id] = 'test'
    data[:data] = { client_vpn_target_networks: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2ClientVPNTargetNetworkAssociation.new(client_vpn_endpoint_id: 'test', association_id: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_client_vpn_target_network_association_exists
    assert @resp.exists?
  end

  def test_client_vpn_target_network_association_available
    assert @resp.available?
  end

  def test_vpc_id
    assert_equal(@resp.vpc_id, 'test')
  end

  def test_association_id
    assert_equal(@resp.association_id, 'test')
  end

  def test_target_network_id
    assert_equal(@resp.target_network_id, 'test')
  end

  def test_code
    assert_equal(@resp.status.code, 'test')
  end

  def test_security_groups
    assert_equal(@resp.security_groups, ["sg-1"])
  end
end 