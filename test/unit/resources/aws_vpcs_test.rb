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
    data[:data] = { :vpcs => [mock_vpc] }
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

  def test_vpcs_instance_tenancys
    assert_equal(@vpcs.instance_tenancys, ['default'])
  end

  def test_vpcs_dhcp_options_ids
    assert_equal(@vpcs.dhcp_options_ids, ['dopt-f557819d'])
  end

  def test_vpcs_is_defaults
    assert_equal(@vpcs.is_defaults, [true])
  end

  def test_vpcs_filtering_not_there
    refute @vpcs.where(:vpc_id => 'bad').exist?
  end

  def test_vpcs_filtering_there
    assert @vpcs.where(:vpc_id => 'vpc-12345678').exist?
  end
end