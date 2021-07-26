require 'helper'
require 'aws_vpcs'
require 'aws-sdk-core'

class AwsVpcsConstructorTest < Minitest::Test
  def test_empty_params_ok
    AwsVpcs.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsVpcs.new('rubbish') }
  end

  def test_vpcs_non_existing_for_empty_response
    refute AwsVpcs.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsVpcsHappyPathTest < Minitest::Test
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
          status_message: 'default',
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
    @vpcs = AwsVpcs.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpcs_exists
    assert @vpcs.exist?
  end

  def test_vpcs_ids
    assert_equal(@vpcs.vpc_ids, ['vpc-12345678'])
  end

  def test_vpcs_cidr_blocks
    assert_equal(@vpcs.cidr_blocks, ['10.0.0.0/27'])
  end

  def test_vpcs_states
    assert_equal(@vpcs.states, ['available'])
  end

  def test_vpcs_instance_tenancies
    assert_equal(@vpcs.instance_tenancies, ['default'])
  end

  def test_vpcs_dhcp_options_ids
    assert_equal(@vpcs.dhcp_options_ids, ['dopt-f557819d'])
  end

  def test_vpcs_is_defaults
    assert_equal(@vpcs.is_default, [true])
  end

  def test_vpcs_filtering_not_there
    refute @vpcs.where(vpc_id: 'bad').exist?
  end

  def test_vpcs_filtering_there
    assert @vpcs.where(vpc_id: 'vpc-12345678').exist?
  end

  def test_associated_cidr_blocks
    assert_includes(@vpcs.associated_cidr_blocks, '10.0.0.0/16')
  end

  def test_ipv6_cidr_blocks
    assert_includes(@vpcs.ipv6_cidr_blocks, '2600:1f16:409:6700::/56')
  end

  def test_ipv6_network_border_groups
    assert_includes(@vpcs.ipv6_network_border_groups, 'us-east-2')
  end

  def test_ipv6_pools
    assert_includes(@vpcs.ipv6_pools, 'Amazon')
  end
end
