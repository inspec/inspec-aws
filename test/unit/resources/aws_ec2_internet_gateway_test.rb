require 'helper'
require 'aws_ec2_internet_gateway'
require 'aws-sdk-core'

class AWSEC2InternetGatewayConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2InternetGateway.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2InternetGateway.new(internet_gateway_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2InternetGateway.new(unexpected: 9) }
  end
end

class AWSEC2InternetGatewaySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_internet_gateways
    mock_data = {}
    mock_data[:internet_gateway_id] = 'test1'
    mock_data[:owner_id] = 'test1'
    data[:data] = { internet_gateways: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2InternetGateway.new(internet_gateway_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_internet_gateways_exists
    assert @resp.exists?
  end

  def test_internet_gateway_id
    assert_equal(@resp.internet_gateway_id, 'test1')
  end

  def test_owner_id
    assert_equal(@resp.owner_id, 'test1')
  end
end