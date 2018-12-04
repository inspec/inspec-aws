require 'helper'
require 'aws_subnet'
require 'aws-sdk-core'

class AwsSubnetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsSubnet.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsSubnet.new(subnet_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsSubnet.new('rubbish') }
  end

  def test_constructor_expected_well_formed_args
    AwsSubnet.new(subnet_id: 'subnet-12345678', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsSubnet.new(unexpected: 9) }
  end

  def test_rejects_invalid_subnet_id
    assert_raises(ArgumentError) { AwsSubnet.new(subnet_id: 'subnet-fail') }
  end

  def test_subnet_non_existing
    refute AwsSubnet.new(subnet_id: 'subnet-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsSubnetHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_subnets
    mock_subnet = {}
    mock_subnet[:vpc_id] = 'vpc-12345678'
    mock_subnet[:subnet_id] = 'subnet-12345678'
    mock_subnet[:cidr_block] = '10.0.0.0/27'
    mock_subnet[:availability_zone] = 'us-east-1a'
    mock_subnet[:available_ip_address_count] = 8
    mock_subnet[:default_for_az] = true
    mock_subnet[:map_public_ip_on_launch] = true
    mock_subnet[:ipv_6_cidr_block_association_set] = []
    mock_subnet[:assign_ipv_6_address_on_creation] = true
    mock_subnet[:state] = 'available'
    data[:data] = { :subnets => [mock_subnet] }
    data[:client] = Aws::EC2::Client
    @subnet = AwsSubnet.new(subnet_id: 'subnet-12345678', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_subnet_exists
    assert @subnet.exists?
  end

  def test_subnet_id
    assert_equal(@subnet.subnet_id, 'subnet-12345678')
  end

  def test_vpc_id
    assert_equal(@subnet.vpc_id, 'vpc-12345678')
  end

  def test_subnet_cidr_block
    assert_equal(@subnet.cidr_block, '10.0.0.0/27')
  end

  def test_subnet_state
    assert_equal(@subnet.state, 'available')
  end

  def test_subnet_az
    assert_equal(@subnet.availability_zone, 'us-east-1a')
  end

  def test_subnet_ip_count
    assert_equal(@subnet.available_ip_address_count, 8)
  end

  def test_subnet_ip6_cidr_block_set
    assert_equal(@subnet.ipv_6_cidr_block_association_set, [])
  end

  def test_subnet_available
    assert @subnet.available?
  end

  def test_subnet_default_for_az
    assert @subnet.default_for_az?
  end

  def test_subnet_mapping_public_ip_on_launch
    assert @subnet.mapping_public_ip_on_launch?
  end

  def test_subnet_assigning_ipv_6_address_on_creation
    assert @subnet.assigning_ipv_6_address_on_creation?
  end
end

class AwsSubnetFalsePropertiesTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_subnets
    mock_subnet = {}
    mock_subnet[:subnet_id] = 'subnet-12345678'
    mock_subnet[:default_for_az] = false
    mock_subnet[:map_public_ip_on_launch] = false
    mock_subnet[:assign_ipv_6_address_on_creation] = false
    mock_subnet[:state] = 'unavailable'
    data[:data] = { :subnets => [mock_subnet] }
    data[:client] = Aws::EC2::Client
    @subnet = AwsSubnet.new(subnet_id: 'subnet-12345678', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_subnet_exists
    assert @subnet.exists?
  end

  def test_subnet_id
    assert_equal(@subnet.subnet_id, 'subnet-12345678')
  end

  def test_subnet_available
    refute @subnet.available?
  end

  def test_subnet_default_for_az
    refute @subnet.default_for_az?
  end

  def test_subnet_mapping_public_ip_on_launch
    refute @subnet.mapping_public_ip_on_launch?
  end

  def test_subnet_assigning_ipv_6_address_on_creation
    refute @subnet.assigning_ipv_6_address_on_creation?
  end
end