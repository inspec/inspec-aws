require 'helper'
require 'aws_ec2_network_interface'
require 'aws-sdk-core'

class AWSEC2NetworkInterfaceConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2NetworkInterface.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2NetworkInterface.new(network_interface_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2NetworkInterface.new(unexpected: 9) }
  end
end

class AWSEC2NetworkInterfaceSuccessPathTest < Minitest::Test

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
    data[:data] = { network_interfaces: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2NetworkInterface.new(network_interface_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_network_interfaces_exists
    assert @resp.exists?
  end

  def test_availability_zone
    assert_equal(@resp.availability_zone, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_interface_type
    assert_equal(@resp.interface_type, 'test1')
  end

  def test_mac_address
    assert_equal(@resp.mac_address, 'test1')
  end

  def test_network_interface_id
    assert_equal(@resp.network_interface_id, 'test1')
  end

  def test_outpost_arn
    assert_equal(@resp.outpost_arn, 'test1')
  end

  def test_owner_id
    assert_equal(@resp.owner_id, 'test1')
  end

  def test_private_dns_name
    assert_equal(@resp.private_dns_name, 'test1')
  end

  def test_private_ip_address
    assert_equal(@resp.private_ip_address, 'test1')
  end

  def test_requester_id
    assert_equal(@resp.requester_id, 'test1')
  end

  def test_requester_managed
    assert_equal(@resp.requester_managed, true)
  end

  def test_subnet_id
    assert_equal(@resp.subnet_id, 'test1')
  end
end