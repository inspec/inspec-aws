require 'helper'
require 'aws_ec2_internet_gateways'
require 'aws-sdk-core'

class AWSEC2InternetGatewaysConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2InternetGateways.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2InternetGateways.new('rubbish') }
  end

  def test_internet_gateways_non_existing_for_empty_response
    refute AWSEC2InternetGateways.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2InternetGatewaysHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_internet_gateways
    mock_data = {}
    mock_data[:internet_gateway_id] = 'test1'
    mock_data[:owner_id] = 'test1'
    data[:data] = { :internet_gateways => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2InternetGateways.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_internet_gateway_ids
    assert_equal(@resp.internet_gateway_ids, ['test1'])
  end

  def test_owner_ids
    assert_equal(@resp.owner_ids, ['test1'])
  end
end