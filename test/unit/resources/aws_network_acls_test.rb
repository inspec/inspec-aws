require 'helper'
require 'aws_network_acls'
require 'aws-sdk-core'
require_relative 'mock/aws_network_acl_mock'

class AwsNetworkACLsConstructorTest < Minitest::Test
  def test_empty_params_ok
    AwsNetworkACLs.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsNetworkACLs.new('random') }
  end

  def test_network_acls_non_existing_for_empty_response
    refute AwsNetworkACLs.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsNetworkACLsConstructorIDTest < Minitest::Test
  def setup
    @mock_nw_acl = AwsNetworkACLMock.new

    @network_acls = AwsNetworkACLs.new(client_args: { stub_responses: true },
                                          stub_data: [@mock_nw_acl.multiple_stub_data])
  end

  def test_exists
    assert(@network_acls.exist?)
  end

  def test_default_network_acl_ids
    refute_includes(@network_acls.default_network_acl_ids, @mock_nw_acl.network_acl_id)
  end

  def test_associated_subnet_ids
    assert_includes(@network_acls.associated_subnet_ids, @mock_nw_acl.associated_subnet_id)
  end

  def test_network_acl_association_ids
    assert_includes(@network_acls.network_acl_association_ids, @mock_nw_acl.network_acl_association_id)
  end

  def test_entries_port_ranges
    assert_includes(@network_acls.entries_port_ranges, @mock_nw_acl.egress[:port_range][:from])
  end

  def test_entries_protocols
    assert_includes(@network_acls.entries_protocols, @mock_nw_acl.egress[:protocol])
  end

  def test_entries_rule_actions
    assert_includes(@network_acls.entries_rule_actions, @mock_nw_acl.egress[:rule_action])
  end

  def test_entries_rule_numbers
    assert_includes(@network_acls.entries_rule_numbers, @mock_nw_acl.egress[:rule_number])
  end
end
