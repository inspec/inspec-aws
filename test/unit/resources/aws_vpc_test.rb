require 'helper'
require 'aws_vpc'
require 'aws-sdk-core'

class AwsVpcConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsVpc.new(client_args: { stub_responses: true })
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsVpc.new('rubbish') }
  end

  def test_accepts_vpc_id_as_hash_eight_sign
    AwsVpc.new(vpc_id: 'vpc-1234abcd', client_args: { stub_responses: true })
  end

  def test_accepts_vpc_id_as_hash
    AwsVpc.new(vpc_id: 'vpc-abcd123454321dcba', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsVpc.new(rubbish: 9) }
  end

  def test_rejects_invalid_vpc_id
    assert_raises(ArgumentError) { AwsVpc.new(vpc_id: 'vpc-rubbish') }
  end

  def test_vpc_non_existing
    refute AwsVpc.new(vpc_id: 'vpc-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsVpcHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_vpcs
    mock_vpc = {}
    mock_vpc[:vpc_id] = 'vpc-12345678'
    mock_vpc[:cidr_block] = '10.0.0.0/27'
    mock_vpc[:state] = 'available'
    mock_vpc[:instance_tenancy] = 'default'
    mock_vpc[:dhcp_options_id] = 'dopt-f557819d'
    mock_vpc[:is_default] = true
    data[:data] = { :vpcs => [mock_vpc] }
    data[:client] = Aws::EC2::Client
    @vpc = AwsVpc.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpc_exists
    assert @vpc.exists?
  end

  def test_vpc_id
    assert_equal(@vpc.vpc_id, 'vpc-12345678')
  end

  def test_vpc_cidr_block
    assert_equal(@vpc.cidr_block, '10.0.0.0/27')
  end

  def test_vpc_state
    assert_equal(@vpc.state, 'available')
    assert @vpc.available?
  end

  def test_vpc_instance_tenancy
    assert_equal(@vpc.instance_tenancy, 'default')
  end

  def test_vpc_dhcp_options_id
    assert_equal(@vpc.dhcp_options_id, 'dopt-f557819d')
  end

  def test_vpc_is_default
    assert @vpc.default?
  end
end

class AwsNonDefaultTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_vpcs
    mock_vpc = {}
    mock_vpc[:vpc_id] = 'vpc-12345678'
    mock_vpc[:is_default] = false
    data[:data] = { :vpcs => [mock_vpc] }
    data[:client] = Aws::EC2::Client
    @vpc = AwsVpc.new(vpc_id: 'vpc-12345678', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpc_id
    assert_equal(@vpc.vpc_id, 'vpc-12345678')
  end

  def test_vpc_is_not_default
    refute @vpc.default?
  end
end