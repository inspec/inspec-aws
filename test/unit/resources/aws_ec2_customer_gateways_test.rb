require 'helper'
require 'aws_ec2_customer_gateways'
require 'aws-sdk-core'

class AWSEC2CustomerGatewaysConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2CustomerGateways.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2CustomerGateways.new('rubbish') }
  end

  def test_customer_gateways_non_existing_for_empty_response
    refute AWSEC2CustomerGateways.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2CustomerGatewaysHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_customer_gateways
    mock_data = {}
    mock_data[:bgp_asn] = 'test1'
    mock_data[:customer_gateway_id] = 'test1'
    mock_data[:ip_address] = 'test1'
    mock_data[:certificate_arn] = 'test1'
    mock_data[:state] = 'test1'
    mock_data[:type] = 'test1'
    mock_data[:device_name] = 'test1'
    mock_data[:tags] = []
    data[:data] = { :customer_gateways => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2CustomerGateways.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_bgp_asns
    assert_equal(@resp.bgp_asns, ['test1'])
  end

  def test_customer_gateway_ids
    assert_equal(@resp.customer_gateway_ids, ['test1'])
  end

  def test_ip_addresses
    assert_equal(@resp.ip_addresses, ['test1'])
  end

  def test_certificate_arns
    assert_equal(@resp.certificate_arns, ['test1'])
  end

  def test_states
    assert_equal(@resp.states, ['test1'])
  end

  def test_types
    assert_equal(@resp.types, ['test1'])
  end

  def test_device_name
    assert_equal(@resp.device_names, ['test1'])
  end

  def test_tags
    assert_equal(@resp.tags, [[]])
  end
end
