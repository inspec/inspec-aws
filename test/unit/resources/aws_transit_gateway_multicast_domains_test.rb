require 'helper'
require 'aws_transit_gateway_multicast_domains'
require 'aws-sdk-core'

class AWSTransitGatewayMulticastDomainsConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) {AWSTransitGatewayMulticastDomains.new(transit_gateway_multicast_domain_id: '', client_args: { stub_responses: true })}
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastDomains.new('rubbish') }
  end
end

class AWSTransitGatewayMulticastDomainsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_transit_gateway_multicast_domains
    mock_data = {}
    mock_data[:transit_gateway_multicast_domain_id] = 'test1'
    mock_data[:transit_gateway_id] = 'test1'
    mock_data[:transit_gateway_multicast_domain_arn] = 'test1'
    mock_data[:owner_id] = 'test1'
    mock_data[:state] = 'test1'
    data[:data] = { :transit_gateway_multicast_domains => [mock_data] }
    data[:client] = Aws::EC2::Client
    @transit_gateway_multicast_domains = AWSTransitGatewayMulticastDomains.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_transit_gateway_multicast_domain_ids
    assert_equal(@transit_gateway_multicast_domains.transit_gateway_multicast_domain_ids, ['test1'])
  end

  def test_transit_gateway_ids
    assert_equal(@transit_gateway_multicast_domains.transit_gateway_ids, ['test1'])
  end

  def test_transit_gateway_multicast_domain_arns
    assert_equal(@transit_gateway_multicast_domains.transit_gateway_multicast_domain_arns, ['test1'])
  end

  def test_owner_ids
    assert_equal(@transit_gateway_multicast_domains.owner_ids, ['test1'])
  end

  def test_states
    assert_equal(@transit_gateway_multicast_domains.states, ['test1'])
  end
end