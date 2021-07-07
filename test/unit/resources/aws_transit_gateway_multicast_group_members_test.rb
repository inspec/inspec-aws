require 'helper'
require 'aws_transit_gateway_multicast_group_members'
require 'aws-sdk-core'

class AWSTransitGatewayMulticastGroupMembersConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) {AWSTransitGatewayMulticastGroupMembers.new(transit_gateway_multicast_domain_id: '', client_args: { stub_responses: true })}
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastGroupMembers.new('rubbish') }
  end
end

class AWSTransitGatewayMulticastGroupMembersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :search_transit_gateway_multicast_groups
    mock_data = {}
    mock_data[:group_ip_address] = 'test1'
    mock_data[:transit_gateway_attachment_id] = 'test1'
    mock_data[:subnet_id] = 'test1'
    mock_data[:resource_id] = 'test1'
    mock_data[:resource_type] = 'test1'
    mock_data[:resource_owner_id] = 'test1'
    mock_data[:network_interface_id] = 'test1'
    mock_data[:group_member] = true
    mock_data[:group_source] = true
    mock_data[:member_type] = 'test1'
    mock_data[:source_type] = 'test1'
    data[:data] = { :multicast_groups => [mock_data] }
    data[:client] = Aws::EC2::Client
    @multicast_groups = AWSTransitGatewayMulticastGroupMembers.new(transit_gateway_multicast_domain_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_group_ip_addresses
    assert_equal(@multicast_groups.group_ip_addresses, ['test1'])
  end

  def test_transit_gateway_attachment_ids
    assert_equal(@multicast_groups.transit_gateway_attachment_ids, ['test1'])
  end

  def test_subnet_ids
    assert_equal(@multicast_groups.subnet_ids, ['test1'])
  end

  def test_resource_ids
    assert_equal(@multicast_groups.resource_ids, ['test1'])
  end

  def test_resource_types
    assert_equal(@multicast_groups.resource_types, ['test1'])
  end

  def test_resource_owner_ids
    assert_equal(@multicast_groups.resource_owner_ids, ['test1'])
  end

  def test_network_interface_ids
    assert_equal(@multicast_groups.network_interface_ids, ['test1'])
  end

  def test_group_members
    assert_equal(@multicast_groups.group_members, [true])
  end

  def test_group_sources
    assert_equal(@multicast_groups.group_sources, [true])
  end

  def test_member_types
    assert_equal(@multicast_groups.member_types, ['test1'])
  end

  def test_source_types
    assert_equal(@multicast_groups.source_types, ['test1'])
  end
end