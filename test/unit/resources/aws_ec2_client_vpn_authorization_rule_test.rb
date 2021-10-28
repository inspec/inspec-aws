require 'helper'
require 'aws_ec2_client_vpn_authorization_rule'
require 'aws-sdk-core'

class AWSEC2ClientVPNAuthorizationRuleConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2ClientVPNAuthorizationRule.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_client_vpn_endpoint_id_as_hash_eight_sign
    AWSEC2ClientVPNAuthorizationRule.new(client_vpn_endpoint_id: 'test', group_id: 'test', client_args: { stub_responses: true })
  end

  def test_accepts_client_vpn_endpoint_id_as_hash
    AWSEC2ClientVPNAuthorizationRule.new(client_vpn_endpoint_id: 'test', group_id: 'test', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2ClientVPNAuthorizationRule.new(rubbish: 9) }
  end
end

class AWSEC2ClientVPNAuthorizationRulePathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_client_vpn_authorization_rules
    mock_data = {}
    mock_data[:client_vpn_endpoint_id] = "test"
    mock_data[:description] = 'test'
    mock_data[:group_id] = 'test'
    mock_data[:destination_cidr] = 'test'
    mock_data[:access_all] = false
    mock_data[:status] = { code: "test", message: "test" }
    data[:data] = { authorization_rules: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2ClientVPNAuthorizationRule.new(client_vpn_endpoint_id: 'test', group_id: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_client_vpn_endpoint_authorization_rules_exists
    assert @resp.exists?
  end

  def test_client_vpn_endpoint_authorization_rules_available
    assert @resp.available?
  end

  def test_client_vpn_endpoint_id
    assert_equal(@resp.client_vpn_endpoint_id, 'test')
  end

  def test_description
    assert_equal(@resp.description, 'test')
  end

  def test_destination_cidr
    assert_equal(@resp.destination_cidr, 'test')
  end

  def test_code
    assert_equal(@resp.status.code, 'test')
  end

  def test_access_all
    assert_equal(@resp.access_all, false)
  end
end 