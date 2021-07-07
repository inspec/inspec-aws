require 'helper'
require 'aws_transit_gateway_multicast_domain_associations'
require 'aws-sdk-core'

class AWSTransitGatewayMulticastDomainAssociationsConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) {AWSTransitGatewayMulticastDomainAssociations.new(client_args: { stub_responses: true })}
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastDomainAssociations.new('rubbish') }
  end
end

class AWSTransitGatewayMulticastDomainAssociationsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_transit_gateway_multicast_domain_associations
    mock_data = {}
    mock_data[:transit_gateway_multicast_domain_id] = 'test1'
    mock_data[:transit_gateway_id] = 'test1'
    mock_data[:transit_gateway_multicast_domain_arn] = 'test1'
    mock_data[:state] = 'test1'
    mock_data[:creation_time] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:tags] = []
    data[:data] = { transit_gateway_multicast_domains: mock_data }
    data[:client] = Aws::EC2::Client
    @transit_gateway_multicast_domains = AWSTransitGatewayMulticastDomainAssociation.new(client_args: { stub_responses: true }, stub_data: [data])
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

  def test_states
    assert_equal(@transit_gateway_multicast_domains.states, ['test1'])
  end

  def test_creation_times
    assert_equal(@transit_gateway_multicast_domains.creation_times, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_tags
    assert_equal(@transit_gateway_multicast_domains.tags, [[]])
  end
end