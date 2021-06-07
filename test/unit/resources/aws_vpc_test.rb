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
    mock_vpc[:cidr_block_association_set] = [
      {
        association_id: 'vpc-cidr-assoc-0d015d4056e31540d',
        cidr_block: '10.0.0.0/16',
        cidr_block_state: {
          state: 'associated',
        },
      },
      {
        association_id: 'vpc-cidr-assoc-0d015d4056e315123',
        cidr_block: '170.0.0.1/17',
        cidr_block_state: {
          state: 'disassociated',
        },
      },
    ]
    mock_vpc[:ipv_6_cidr_block_association_set] = [
      {
        association_id: 'vpc-cidr-assoc-0542c490c8189946a',
        ipv_6_cidr_block: '2600:1f16:409:6700::/56',
        ipv_6_cidr_block_state: {
          state: 'associated',
        },
        network_border_group: 'us-east-2',
        ipv_6_pool: 'Amazon',
      },
    ]
    data[:data] = { vpcs: [mock_vpc] }
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
    refute @vpc.pending?
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

  def test_vpc_instance_tendency_type
    assert_equal(@vpc.instance_tenancy, 'default')
    assert @vpc.default_instance?
    refute @vpc.dedicated_instance?
    refute @vpc.host_instance?
  end

  def test_associated_cidr_blocks
    assert_includes(@vpc.associated_cidr_blocks, '10.0.0.0/16')
  end

  def test_disassociated_cidr_blocks
    assert_includes(@vpc.disassociated_cidr_blocks, '170.0.0.1/17')
  end

  def test_has_cidr_block_associated?
    assert @vpc.has_cidr_block_associated?('10.0.0.0/16')
  end

  def test_has_cidr_block_disassociated?
    assert @vpc.has_cidr_block_disassociated?('170.0.0.1/17')
  end

  def test_has_ipv6_cidr_block_associated?
    assert @vpc.has_ipv6_cidr_block_associated?('2600:1f16:409:6700::/56')
  end

  def test_has_ipv6_cidr_block_disassociated?
    refute @vpc.has_ipv6_cidr_block_disassociated?('2600:1f16:409:6700::/76')
  end
end

class AwsNonDefaultTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_vpcs
    mock_vpc = {}
    mock_vpc[:vpc_id] = 'vpc-12345678'
    mock_vpc[:is_default] = false
    mock_vpc[:cidr_block_association_set] = [
      {
        association_id: 'vpc-cidr-assoc-0d015d4056e31540d',
        cidr_block: '10.0.0.0/16',
        cidr_block_state: {
          state: 'associated',
        },
      },
    ]
    mock_vpc[:ipv_6_cidr_block_association_set] = [
      {
        association_id: 'vpc-cidr-assoc-0542c490c8189946a',
        ipv_6_cidr_block: '2600:1f16:409:6700::/56',
        ipv_6_cidr_block_state: {
          state: 'associated',
        },
        network_border_group: 'us-east-2',
        ipv_6_pool: 'Amazon',
      },
    ]
    data[:data] = { vpcs: [mock_vpc] }
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
