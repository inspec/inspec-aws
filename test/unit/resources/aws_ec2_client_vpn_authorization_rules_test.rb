require 'helper'
require 'aws_ec2_client_vpn_authorization_rules'
require 'aws-sdk-core'

class AWSEC2ClientVPNAuthorizationRulesConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2ClientVPNAuthorizationRules.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_client_vpn_endpoint_id_as_hash_eight_sign
    AWSEC2ClientVPNAuthorizationRules.new(client_vpn_endpoint_id: 'test', client_args: { stub_responses: true })
  end

  def test_accepts_client_vpn_endpoint_id_as_hash
    AWSEC2ClientVPNAuthorizationRules.new(client_vpn_endpoint_id: 'test', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2ClientVPNAuthorizationRules.new(rubbish: 9) }
  end
end

class AWSEC2ClientVPNAuthorizationRulesPathTest < Minitest::Test
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
    @resp = AWSEC2ClientVPNAuthorizationRules.new(client_vpn_endpoint_id: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_client_vpn_endpoint_rule_exists
    assert @resp.exists?
  end

  def test_client_vpn_endpoint_rule_available
    assert @resp.available?
  end

  def test_client_vpn_endpoint_ids
    assert_equal(@resp.client_vpn_endpoint_ids, ['test'])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test'])
  end

  def test_destination_cidr
    assert_equal(@resp.destination_cidr, ['test'])
  end

  def test_codes
    assert_equal(@resp.status_codes, ['test'])
  end

  def test_access_all
    assert_equal(@resp.access_all, [false])
  end
end 