require 'helper'
require 'aws_ec2_network_interfaces'
require 'aws-sdk-core'

class AWSEC2NetworkInterfacesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2NetworkInterfaces.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2NetworkInterfaces.new('rubbish') }
  end

  def test_network_interfaces_non_existing_for_empty_response
    refute AWSEC2NetworkInterfaces.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2NetworkInterfacesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_network_interfaces
    mock_data = {}
    mock_data[:availability_zone] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:interface_type] = 'test1'
    mock_data[:mac_address] = 'test1'
    mock_data[:network_interface_id] = 'test1'
    mock_data[:outpost_arn] = 'test1'
    mock_data[:owner_id] = 'test1'
    mock_data[:private_dns_name] = 'test1'
    mock_data[:private_ip_address] = 'test1'
    mock_data[:requester_id] = 'test1'
    mock_data[:requester_managed] = true
    mock_data[:subnet_id] = 'test1'
    data[:data] = { :network_interfaces => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2NetworkInterfaces.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_availability_zones
    assert_equal(@resp.availability_zones, ['test1'])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end

  def test_interface_types
    assert_equal(@resp.interface_types, ['test1'])
  end

  def test_mac_addresses
    assert_equal(@resp.mac_addresses, ['test1'])
  end

  def test_network_interface_ids
    assert_equal(@resp.network_interface_ids, ['test1'])
  end

  def test_outpost_arns
    assert_equal(@resp.outpost_arns, ['test1'])
  end

  def test_owner_ids
    assert_equal(@resp.owner_ids, ['test1'])
  end

  def test_private_dns_names
    assert_equal(@resp.private_dns_names, ['test1'])
  end

  def test_private_ip_addresses
    assert_equal(@resp.private_ip_addresses, ['test1'])
  end

  def test_requester_ids
    assert_equal(@resp.requester_ids, ['test1'])
  end

  def test_requester_managed
    assert_equal(@resp.requester_managed, [true])
  end

  def test_subnet_ids
    assert_equal(@resp.subnet_ids, ['test1'])
  end
end