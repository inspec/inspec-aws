require 'helper'
require 'aws_ec2_egress_only_internet_gateway'
require 'aws-sdk-core'

class AWSEC2EgressOnlyInternetGatewayConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2EgressOnlyInternetGateway.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2EgressOnlyInternetGateway.new(egress_only_internet_gateway_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2EgressOnlyInternetGateway.new(unexpected: 9) }
  end
end

class AWSEC2EgressOnlyInternetGatewaySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_egress_only_internet_gateways
    mock_data = {}
    mock_data[:attachments] = [
      state: "test1",
      vpc_id: "test1"
    ]
    mock_data[:egress_only_internet_gateway_id] = 'test1'
    mock_data[:tags] = []
    data[:data] = { egress_only_internet_gateways: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2EgressOnlyInternetGateway.new(egress_only_internet_gateway_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_egress_only_internet_gateways_exists
    assert @resp.exists?
  end

  def test_attachments_state
    assert_equal(@resp.attachments[0].state, 'test1')
  end

  def test_attachments_vpc_ids
    assert_equal(@resp.attachments[0].vpc_id, 'test1')
  end

  def test_egress_only_internet_gateway_id
    assert_equal(@resp.egress_only_internet_gateway_id, 'test1')
  end

  def test_tags
    assert_equal(@resp.tags, {})
  end
end
