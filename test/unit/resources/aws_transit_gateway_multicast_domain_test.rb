require 'helper'
require 'aws_transit_gateway_multicast_domain'
require 'aws-sdk-core'

class AWSTransitGatewayMulticastDomainConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastDomain.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastDomain.new(transit_gateway_multicast_domain_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastDomain.new(unexpected: 9) }
  end
end

class AWSTransitGatewayMulticastDomainSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_transit_gateway_multicast_domains
    mock_data = {}
    mock_data[:transit_gateway_multicast_domain_id] = 'test1'
    mock_data[:transit_gateway_id] = 'test1'
    mock_data[:transit_gateway_multicast_domain_arn] = 'test1'
    mock_data[:owner_id] = 'test1'
    mock_data[:state] = 'test1'
    data[:data] = { transit_gateway_multicast_domains: [mock_data] }
    data[:client] = Aws::EC2::Client
    @transit_gateway_multicast_domains = AWSTransitGatewayMulticastDomain.new(transit_gateway_multicast_domain_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_transit_gateway_multicast_domains_exists
    assert @transit_gateway_multicast_domains.exists?
  end

  def test_transit_gateway_multicast_domain_id
    assert_equal(@transit_gateway_multicast_domains.transit_gateway_multicast_domain_id, 'test1')
  end

  def test_transit_gateway_id
    assert_equal(@transit_gateway_multicast_domains.transit_gateway_id, 'test1')
  end

  def test_transit_gateway_multicast_domain_arn
    assert_equal(@transit_gateway_multicast_domains.transit_gateway_multicast_domain_arn, 'test1')
  end

  def test_owner_id
    assert_equal(@transit_gateway_multicast_domains.owner_id, 'test1')
  end

  def test_state
    assert_equal(@transit_gateway_multicast_domains.state, 'test1')
  end
end