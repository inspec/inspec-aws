require 'helper'
require 'aws_ec2_egress_only_internet_gateways'
require 'aws-sdk-core'

class AWSEC2EgressOnlyInternetGatewaysConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2EgressOnlyInternetGateways.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2EgressOnlyInternetGateways.new('rubbish') }
  end

  def test_egress_only_internet_gateways_non_existing_for_empty_response
    refute AWSEC2EgressOnlyInternetGateways.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2EgressOnlyInternetGatewaysHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_egress_only_internet_gateways
    mock_data = {}
    mock_data[:attachments] = []
    mock_data[:egress_only_internet_gateway_id] = 'test1'
    mock_data[:tags] = []
    data[:data] = { :egress_only_internet_gateways => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2EgressOnlyInternetGateways.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_attachments
    assert_equal(@resp.attachments, [[]])
  end

  def test_egress_only_internet_gateway_ids
    assert_equal(@resp.egress_only_internet_gateway_ids, ['test1'])
  end

  def test_tags
    assert_equal(@resp.tags, [[]])
  end
end
