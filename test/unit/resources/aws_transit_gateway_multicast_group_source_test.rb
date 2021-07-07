require 'helper'
require 'aws_transit_gateway_multicast_group_source'
require 'aws-sdk-core'

class AWSTransitGatewayMulticastGroupSourceConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastGroupSource.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastGroupSource.new(transit_gateway_multicast_domain_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastGroupSource.new(unexpected: 9) }
  end
end

class AWSTransitGatewayMulticastGroupSourceSuccessPathTest < Minitest::Test

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
    @multicast_groups = AWSTransitGatewayMulticastGroupSource.new(transit_gateway_multicast_domain_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_multicast_groups_exists
    assert @multicast_groups.exists?
  end

  def test_group_ip_address
    assert_equal(@multicast_groups.group_ip_address, 'test1')
  end

  def test_transit_gateway_attachment_id
    assert_equal(@multicast_groups.transit_gateway_attachment_id, 'test1')
  end

  def test_subnet_id
    assert_equal(@multicast_groups.subnet_id, 'test1')
  end

  def test_resource_id
    assert_equal(@multicast_groups.resource_id, 'test1')
  end

  def test_resource_type
    assert_equal(@multicast_groups.resource_type, 'test1')
  end

  def test_resource_owner_id
    assert_equal(@multicast_groups.resource_owner_id, 'test1')
  end

  def test_network_interface_id
    assert_equal(@multicast_groups.network_interface_id, 'test1')
  end

  def test_group_member
    assert_equal(@multicast_groups.group_member, true)
  end

  def test_group_source
    assert_equal(@multicast_groups.group_source, true)
  end

  def test_member_type
    assert_equal(@multicast_groups.member_type, 'test1')
  end

  def test_source_type
    assert_equal(@multicast_groups.source_type, 'test1')
  end
end