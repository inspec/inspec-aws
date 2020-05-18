require 'helper'
require 'aws_internet_gateways'
require "aws-sdk-core"
require_relative 'mock/aws_internet_gateway_mock'

class AwsInternetGatewaysConstructorTest < Minitest::Test

  def test_empty_params_ok
    assert AwsInternetGateways.new(client_args: { stub_responses: true })
  end

  def test_params_not_ok
    assert_raises(ArgumentError) { AwsInternetGateways.new(id: 'igw-12345678') }
  end

  def test_non_existing_igws
    refute AwsInternetGateways.new(client_args: { stub_responses: true }).exist?
  end

end

class AwsInternetGatewaysTest < Minitest::Test

  def setup
    # Create a number of mock gateway
    number_of_mock = 5
    @mock_gateway_list = AwsInternetGatewayMock.new.multiple(number_of_mock)

    # Create stub data.
    data = {}
    data[:data] = { :internet_gateways => @mock_gateway_list }
    data[:client] = Aws::EC2::Client
    data[:method] = :describe_internet_gateways

    # Create stub gateways with mock data.
    @gateways = AwsInternetGateways.new(
        client_args: { stub_responses: true },
        stub_data: [data]
    )
  end

  def test_gateways_exists
    assert @gateways.exist?
  end

  def test_id
    @gateways.ids.zip(@mock_gateway_list).each do |id, m_g|
      assert_equal(id, m_g[:internet_gateway_id])
    end
  end

  def test_name
    @gateways.names.zip(@mock_gateway_list).each do |name, m_g|
      assert_equal(name, m_g[:tags][0][:value])
    end
  end

  def test_vpc_id
    @gateways.vpc_ids.zip(@mock_gateway_list).each do |vpc_id, m_g|
      assert_equal(vpc_id, m_g[:attachments][0][:vpc_id])
    end
  end

  def test_attached
    @gateways.attachment_states.zip(@mock_gateway_list).each do |a_s, m_g|
      assert_equal(a_s, m_g[:attachments].first.empty? ? 'detached' : 'attached')
    end
  end

  def test_owner_id
    @gateways.owner_ids.zip(@mock_gateway_list).each do |o_id, m_g|
      assert_equal(o_id, m_g[:owner_id])
    end
  end
end
