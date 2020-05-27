require 'helper'
require 'aws_nat_gateway'
require "aws-sdk-core"
require_relative 'mock/aws_nat_gateway_mock'

class AwsNatGatewayConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsNatGateway.new() }
  end

  def test_multiple_params_ok
    assert AwsNatGateway.new(id: 'nat-12345678', name:'my-nat', client_args: { stub_responses: true })
  end

  def test_invalid_id
    assert_raises(ArgumentError) { AwsNatGateway.new(id: 'aa') }
  end

  def test_too_long_id
    assert_raises(ArgumentError) { AwsNatGateway.new(id: 'nat-' + 'a'*30) }
  end

  def test_too_long_name
    assert_raises(ArgumentError) { AwsNatGateway.new(name: 'a'*257) }
  end

  def test_unrecognized_identifiers
    assert_raises(ArgumentError) { AwsNatGateway.new(rubbish_id: 'fs-12345678') }
  end
end

class AwsNatGatewayTest < Minitest::Test

  def setup
    # Create a mock resource
    number_of_mock = 1
    @mock_nat_gateway_list = AwsNatGatewayMock.new.multiple(number_of_mock)

    # Create stub data
    data = {}
    data[:data] = { nat_gateways: @mock_nat_gateway_list }
    data[:client] = Aws::EC2::Client
    data[:method] = :describe_nat_gateways

    # This is for brevity.
    @m_g = @mock_nat_gateway_list.first

    # Create a stub gateway with mock data.
    @gateway = AwsNatGateway.new(
        id: @m_g[:nat_gateway_id],
        client_args: { stub_responses: true },
        stub_data: [data],
    )
  end

  def test_gateway_exists
    assert @gateway.exists?
  end

  def test_id
    assert_equal(@gateway.id, @m_g[:nat_gateway_id])
  end

  def test_nat_gateway_id
    assert_equal(@gateway.nat_gateway_id, @m_g[:nat_gateway_id])
  end

  def test_name
    assert_equal(@gateway.name, @m_g[:tags][0][:value])
  end

  def test_vpc_id
    assert_equal(@gateway.vpc_id, @m_g[:vpc_id])
  end

  def test_state
    assert_equal(@gateway.state, @m_g[:state])
  end

  def test_subnet_id
    assert_equal(@gateway.subnet_id, @m_g[:subnet_id])
  end

  def test_nat_gateway_address_set
    assert_equal(@gateway.nat_gateway_address_set, @m_g[:nat_gateway_addresses].first)
  end
end
