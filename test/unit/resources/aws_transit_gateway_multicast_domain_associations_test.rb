require 'helper'
require 'aws_transit_gateway_multicast_domain_associations'
require 'aws-sdk-core'

class AWSTransitGatewayMulticastDomainAssociationsConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) {AWSTransitGatewayMulticastDomainAssociations.new(transit_gateway_multicast_domain_id: '', client_args: { stub_responses: true })}
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
    mock_data[:transit_gateway_attachment_id] = 'test1'
    mock_data[:resource_id] = 'test1'
    mock_data[:resource_type] = 'test1'
    mock_data[:resource_owner_id] = 'test1'
    data[:data] = { :multicast_domain_associations => [mock_data] }
    data[:client] = Aws::EC2::Client
    @multicast_domain_associations = AWSTransitGatewayMulticastDomainAssociations.new(transit_gateway_multicast_domain_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_transit_gateway_attachment_ids
    assert_equal(@multicast_domain_associations.transit_gateway_attachment_ids, ['test1'])
  end

  def test_resource_ids
    assert_equal(@multicast_domain_associations.resource_ids, ['test1'])
  end

  def test_resource_types
    assert_equal(@multicast_domain_associations.resource_types, ['test1'])
  end

  def test_resource_owner_ids
    assert_equal(@multicast_domain_associations.resource_owner_ids, ['test1'])
  end
end