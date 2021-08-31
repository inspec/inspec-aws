require 'helper'
require 'aws_transit_gateway_connects'
require 'aws-sdk-core'

class AWSTransitGatewayConnectsConstructorTest < Minitest::Test

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSTransitGatewayConnects.new('rubbish') }
  end
end

class AWSTransitGatewayConnectsHappyPathTest < Minitest::Test

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
    data[:data] = { :transit_gateway_connects => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSTransitGatewayConnects.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_transit_gateway_attachment_ids
    assert_equal(@resp.transit_gateway_attachment_ids, ['test1'])
  end

  def test_transport_transit_gateway_attachment_ids
    assert_equal(@resp.transport_transit_gateway_attachment_ids, ['test1'])
  end

  def test_transit_gateway_ids
    assert_equal(@resp.transit_gateway_ids, ['test1'])
  end

  def test_states
    assert_equal(@resp.states, ['test1'])
  end

  def test_creation_times
    assert_equal(@resp.creation_times, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_tags
    assert_equal(@resp.tags, [[]])
  end
end