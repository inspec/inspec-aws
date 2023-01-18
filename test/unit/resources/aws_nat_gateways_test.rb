require 'helper'
require 'aws_nat_gateways'
require "aws-sdk-core"
require_relative 'mock/aws_nat_gateway_mock'

class AwsNatGatewaysConstructorTest < Minitest::Test

  def test_empty_params_ok
    assert AwsNatGateways.new(client_args: { stub_responses: true })
  end

  def test_params_not_ok
    assert_raises(ArgumentError) { AwsNatGateways.new(id: 'igw-12345678') }
  end

  def test_non_existing_ngws
    refute AwsNatGateways.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsNatGatewaysTest < Minitest::Test

  def setup
    # Create a number of mock resource data
    number_of_mock = 5
    @mock_gateway_list = AwsNatGatewayMock.new.multiple(number_of_mock)

    # Create stub data
    data = {}
    data[:data] = { :nat_gateways => @mock_gateway_list }
    data[:client] = Aws::EC2::Client
    data[:method] = :describe_nat_gateways

    # Create stub gateways with mock data
    @gateways = AwsNatGateways.new(
        client_args: { stub_responses: true },
        stub_data: [data]
    )
  end

  def test_gateways_exists
    assert @gateways.exist?
  end

  def test_id
    @gateways.ids.zip(@mock_gateway_list).each do |id, m_g|
      assert_equal(id, m_g[:nat_gateway_id])
    end
  end

  def test_name
    @gateways.names.zip(@mock_gateway_list).each do |name, m_g|
      assert_equal(name, m_g[:tags][0][:value])
    end
  end

  def test_vpc_id
    @gateways.vpc_ids.zip(@mock_gateway_list).each do |vpc_id, m_g|
      assert_equal(vpc_id, m_g[:vpc_id])
    end
  end

  def test_subnet_id
    @gateways.subnet_ids.zip(@mock_gateway_list).each do |s_id, m_g|
      assert_equal(s_id, m_g[:subnet_id])
    end
  end

  def test_state
    @gateways.states.zip(@mock_gateway_list).each do |state, m_g|
      assert_equal(state, m_g[:state])
    end
  end
end
