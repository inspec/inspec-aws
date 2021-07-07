require 'helper'
require 'aws_transit_gateway_connect'
require 'aws-sdk-core'

class AWSTransitGatewayConnectConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSTransitGatewayConnect.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSTransitGatewayConnect.new(transit_gateway_attachment_ids: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSTransitGatewayConnect.new(unexpected: 9) }
  end
end

class AWSTransitGatewayConnectSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_transit_gateway_connects
    mock_data = {}
    mock_data[:transit_gateway_attachment_id] = 'test1'
    mock_data[:transport_transit_gateway_attachment_id] = 'test1'
    mock_data[:transit_gateway_id] = 'test1'
    mock_data[:state] = 'test1'
    mock_data[:creation_time] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:tags] = []
    data[:data] = { transit_gateway_connects: [mock_data] }
    data[:client] = Aws::EC2::Client
    @multicast_domain_associations = AWSTransitGatewayConnect.new(transit_gateway_attachment_ids: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_multicast_domain_associations_exists
    assert @multicast_domain_associations.exists?
  end

  def test_transit_gateway_attachment_id
    assert_equal(@multicast_domain_associations.transit_gateway_attachment_id, 'test1')
  end

  def test_transport_transit_gateway_attachment_id
    assert_equal(@multicast_domain_associations.transport_transit_gateway_attachment_id, 'test1')
  end

  def test_transit_gateway_id
    assert_equal(@multicast_domain_associations.transit_gateway_id, 'test1')
  end

  def test_state
    assert_equal(@multicast_domain_associations.state, 'test1')
  end

  def test_creation_time
    assert_equal(@multicast_domain_associations.creation_time, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end
end