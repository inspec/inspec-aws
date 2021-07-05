require 'helper'
require 'aws_network_acl'
require 'aws-sdk-core'
require_relative 'mock/aws_network_acl_mock'

class AwsNetworkACLConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsNetworkACL.new(client_args: { stub_responses: true }) }
  end

  def test_raises_invalid_network_acl
    assert_raises(ArgumentError) { AwsNetworkACL.new('not-1234') }
  end

  def test_raises_unrecognized_params
    assert_raises(ArgumentError) { AwsNetworkACL.new(random: 99) }
  end

  def test_raises_invalid_dhcp_id
    assert_raises(ArgumentError) { AwsNetworkACL.new(network_acl_id: 'acl-not-allowed') }
  end

  def test_raises_empty_name
    assert_raises(ArgumentError) { AwsNetworkACL.new(network_acl_id: '') }
  end
end

class AwsNetworkACLConstructorIdTest < Minitest::Test
  def setup
    @network_acl_mock = AwsNetworkACLMock.new
    @network_acl = AwsNetworkACL.new(network_acl_id: @network_acl_mock.network_acl_id,
                                     client_args: { stub_responses: true },
                                     stub_data: [@network_acl_mock.stub_data])
  end

  def test_network_acl_id
    assert_equal(@network_acl.network_acl_id, @network_acl_mock.network_acl_id)
  end

  def test_associated_subnet_ids
    assert_includes(@network_acl.associated_subnet_ids, @network_acl_mock.associated_subnet_id)
  end

  def test_associated
    assert(@network_acl.be_associated)
  end

  def test_association_with_subnet_id
    assert(@network_acl.has_associations?(subnet_id: @network_acl_mock.associated_subnet_id))
  end

  def test_if_network_acl_default
    refute(@network_acl.default?)
  end

  def test_has_egress
    assert(@network_acl.has_egress?)
  end

  def test_has_egress_with_value
    assert(@network_acl.has_egress?(cidr_block: '0.0.0.0/0', rule_action: 'deny'))
  end

  def test_has_ingress
    assert(@network_acl.has_ingress?)
  end

  def test_hash_ingress_with_value
    assert(@network_acl.has_ingress?(cidr_block: '0.0.0.0/0', rule_action: 'deny'))
  end

  def test_dynamic_entry_rule_number
    assert_equal(@network_acl.egress_rule_number_32767.cidr_block, @network_acl_mock.cidr_block)
  end
end
