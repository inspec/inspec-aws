require 'helper'
require 'aws_transit_gateway_multicast_domain_association'
require 'aws-sdk-core'

class AWSTransitGatewayMulticastDomainAssociationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastDomainAssociation.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastDomainAssociation.new(transit_gateway_multicast_domain_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastDomainAssociation.new(unexpected: 9) }
  end
end

class AWSTransitGatewayMulticastDomainAssociationSuccessPathTest < Minitest::Test

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
    @transit_gateway_multicast_domains = AWSTransitGatewayMulticastDomainAssociation.new(transit_gateway_multicast_domain_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
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

  def test_state
    assert_equal(@transit_gateway_multicast_domains.state, 'test1')
  end

  def test_creation_time
    assert_equal(@transit_gateway_multicast_domains.creation_time, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_tags
    assert_equal(@transit_gateway_multicast_domains.tags, [])
  end
end