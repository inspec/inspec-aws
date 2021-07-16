require 'helper'
require 'aws_ec2_eip'
require 'aws-sdk-core'

class AwsEIPConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEc2Eip.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_vpc_endpoint_id_as_hash_eight_sign
    AwsEc2Eip.new(public_ip: '18.191.108.8', client_args: { stub_responses: true })
  end

  def test_accepts_vpc_endpoint_id_as_hash
    AwsEc2Eip.new(public_ip: '18.191.108.8', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsEc2Eip.new(rubbish: 9) }
  end
end

class AwsEIPPathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_addresses
    mock_eip = {}
    mock_eip[:public_ip] = '18.191.108.8'
    mock_eip[:instance_id] = 'i-01a6e9ac9f962f154'
    mock_eip[:allocation_id] = 'eipalloc-0cbcb3faa6f8b1a4a'
    mock_eip[:association_id] = 'eipassoc-0ee2ac8cce27191da'
    mock_eip[:domain] = 'vpc'
    mock_eip[:network_interface_id] = 'eni-04966ef82e61edd26'
    mock_eip[:network_interface_owner_id] = '112758395563'
    mock_eip[:private_ip_address] = '172.31.37.142'
    mock_eip[:public_ipv_4_pool] = 'amazon'
    mock_eip[:network_border_group] = 'us-east-2'
    data[:data] = { addresses: [mock_eip] }
    data[:client] = Aws::EC2::Client
    @addr = AwsEc2Eip.new(public_ip: '18.191.108.8', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_public_ip_exists
    assert @addr.exists?
  end

  def test_public_ip_available
    assert @addr.available?
  end

  def test_public_ip
    assert_equal(@addr.public_ip, '18.191.108.8')
  end

  def test_instance_id
    assert_equal(@addr.instance_id, 'i-01a6e9ac9f962f154')
  end

  def test_allocation_id
    assert_equal(@addr.allocation_id, 'eipalloc-0cbcb3faa6f8b1a4a')
  end

  def test_association_id
    assert_equal(@addr.association_id, 'eipassoc-0ee2ac8cce27191da')
  end

  def test_domain
    assert_equal(@addr.domain, 'vpc')
  end

  def test_network_interface_id
    assert_equal(@addr.network_interface_id, 'eni-04966ef82e61edd26')
  end

  def test_network_interface_owner_id
    assert_equal(@addr.network_interface_owner_id, '112758395563')
  end

  def test_private_ip_address
    assert_equal(@addr.private_ip_address, '172.31.37.142')
  end

  def test_public_ipv_4_pool
    assert_equal(@addr.public_ipv_4_pool, 'amazon')
  end

  def test_network_border_group
    assert_equal(@addr.network_border_group, 'us-east-2')
  end
end
