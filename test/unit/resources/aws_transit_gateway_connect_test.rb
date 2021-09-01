require 'helper'
require 'aws_transit_gateway_connect'
require 'aws-sdk-core'

class AWSTransitGatewayConnectConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSTransitGatewayConnect.new(transit_gateway_attachment_id: '', client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSTransitGatewayConnect.new(transit_gateway_attachment_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSTransitGatewayConnect.new(unexpected: 9) }
  end
end

class AWSTransitGatewayConnectHappyPathTest < Minitest::Test

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
    @resp = AWSTransitGatewayConnect.new(transit_gateway_attachment_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_transit_gateway_connects_exists
    assert @resp.exists?
  end

  def test_transit_gateway_attachment_id
    assert_equal(@resp.transit_gateway_attachment_id, 'test1')
  end

  def test_transport_transit_gateway_attachment_id
    assert_equal(@resp.transport_transit_gateway_attachment_id, 'test1')
  end

  def test_transit_gateway_id
    assert_equal(@resp.transit_gateway_id, 'test1')
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end

  def test_creation_time
    assert_equal(@resp.creation_time, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end
end

