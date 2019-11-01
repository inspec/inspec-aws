require 'helper'
require 'aws_subnets'
require 'aws-sdk-core'

class AwsSubnetsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsSubnets.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsSubnets.new('rubbish') }
  end

  def test_subnets_non_existing_for_empty_response
    refute AwsSubnets.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsSubnetsHappyPathTest < Minitest::Test

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
    @subnets = AwsSubnets.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_subnets_exists
    assert @subnets.exist?
  end

  def test_subnets_ids
    assert_equal(@subnets.subnet_ids, ['subnet-12345678'])
  end

  def test_subnets_vpc_ids
    assert_equal(@subnets.vpc_ids, ['vpc-12345678'])
  end

  def test_subnets_cidr_blocks
    assert_equal(@subnets.cidr_blocks, ['10.0.0.0/27'])
  end

  def test_subnets_states
    assert_equal(@subnets.states, ['available'])
  end

  def test_subnets_availability_zone
    assert_equal(@subnets.availability_zone, ['us-east-1a'])
  end

  def test_subnets_map_public_ip_on_launch
    assert_equal(@subnets.map_public_ip_on_launch, [true])
  end

  def test_subnets_filtering_not_there
    refute @subnets.where(:subnet_id => 'bad').exist?
  end

  def test_subnets_filtering_there
    assert @subnets.where(:subnet_id => 'subnet-12345678').exist?
  end

  def test_subnets_filtering_availability_zone_not_there
    refute @subnets.where(:availability_zone => 'eu-central-1a').exist?
  end

  def test_subnets_filtering_availability_zone_there
    assert @subnets.where(:availability_zone => 'us-east-1a').exist?
  end

  def test_subnets_filtering_map_public_ip_not_there
    refute @subnets.where(:map_public_ip_on_launch => false).exist?
  end

  def test_subnets_filtering_map_public_ip_here
    assert @subnets.where(:map_public_ip_on_launch => true).exist?
  end
end
