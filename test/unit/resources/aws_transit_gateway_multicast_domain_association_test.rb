require 'helper'
require 'aws_transit_gateway_multicast_domain_association'
require 'aws-sdk-core'

class AWSTransitGatewayMulticastDomainAssociationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSTransitGatewayMulticastDomainAssociation.new(transit_gateway_multicast_domain_id: '', client_args: { stub_responses: true }) }
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
    mock_data[:transit_gateway_attachment_id] = 'test1'
    mock_data[:resource_id] = 'test1'
    mock_data[:resource_type] = 'test1'
    mock_data[:resource_owner_id] = 'test1'
    data[:data] = { :multicast_domain_associations => [mock_data] }
    data[:client] = Aws::EC2::Client
    @multicast_domain_associations = AWSTransitGatewayMulticastDomainAssociation.new(transit_gateway_multicast_domain_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_multicast_domain_associations_exists
    assert @multicast_domain_associations.exists?
  end

  def test_transit_gateway_attachment_id
    assert_equal(@multicast_domain_associations.transit_gateway_attachment_id, 'test1')
  end

  def test_resource_id
    assert_equal(@multicast_domain_associations.resource_id, 'test1')
  end

  def test_resource_type
    assert_equal(@multicast_domain_associations.resource_type, 'test1')
  end

  def test_resource_owner_id
    assert_equal(@multicast_domain_associations.resource_owner_id, 'test1')
  end
end