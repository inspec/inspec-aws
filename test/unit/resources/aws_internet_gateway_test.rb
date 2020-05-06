require 'helper'
require 'aws_internet_gateway'
require "aws-sdk-core"
require_relative 'mock/aws_internet_gateway_mock'

class AwsInternetGatewayConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsInternetGateway.new() }
  end

  def test_multiple_params_not_ok
    assert_raises(ArgumentError) { AwsInternetGateway.new(id: 'igw-12345678', name:'my-igw') }
  end

  def test_invalid_id
    assert_raises(ArgumentError) { AwsInternetGateway.new(id: 'aa') }
  end

  def test_too_long_id
    assert_raises(ArgumentError) { AwsInternetGateway.new(id: 'igw-' + 'a'*30) }
  end

  def test_too_long_name
    assert_raises(ArgumentError) { AwsInternetGateway.new(name: 'a'*257) }
  end

  def test_unrecognized_identifiers
    assert_raises(ArgumentError) { AwsInternetGateway.new(rubbish_id: 'fs-12345678') }
  end
end

class AwsInternetGatewayTest < Minitest::Test

  def setup
    # Create a mock gateway
    number_of_mock = 1
    @mock_gateway_ist = AwsInternetGatewayMock.new.multiple(number_of_mock)

    # Create stub data.
    data = {}
    data[:data] = { :internet_gateways => @mock_gateway_ist }
    data[:client] = Aws::EC2::Client
    data[:method] = :describe_internet_gateways

    # This is for brevity.
    @m_g = @mock_gateway_ist.first

    # Create a stub gateway with mock data.
    @gateway = AwsInternetGateway.new(
        id: @m_g[:internet_gateway_id],
        client_args: { stub_responses: true },
        stub_data: [data]
    )
  end

  def test_gateway_exists
    assert @gateway.exists?
  end

  def test_id
    assert_equal(@gateway.id, @m_g[:internet_gateway_id])
  end

  def test_name
    assert_equal(@gateway.name, @m_g[:tags][0][:value])
  end

  def test_vpc_id
    assert_equal(@gateway.vpc_id, @m_g[:attachments][0][:vpc_id])
  end

  def test_attached
    assert @gateway.attached?
  end

  def test_detached
    refute @gateway.detached?
  end
end
