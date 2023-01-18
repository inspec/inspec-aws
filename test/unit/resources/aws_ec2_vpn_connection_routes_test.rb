require 'helper'
require 'aws_ec2_vpn_connection_routes'
require 'aws-sdk-core'

class AWSEC2VPNConnectionRoutesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2VPNConnectionRoutes.new(vpn_connection_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2VPNConnectionRoutes.new('rubbish') }
  end

  def test_vpn_connection_routes_non_existing_for_empty_response
    refute AWSEC2VPNConnectionRoutes.new(vpn_connection_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2VPNConnectionRoutesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_vpn_connections
    mock_data = {}
    mock_data[:routes] = [{
                            destination_cidr_block: 'test1',
                            source: 'test1',
                            state: 'test1'
                          }]
    data[:data] = { :vpn_connections => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2VPNConnectionRoutes.new(vpn_connection_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_destination_cidr_blocks
    assert_equal(@resp.destination_cidr_blocks,  [['test1']])
  end

  def test_source
    assert_equal(@resp.sources,  [['test1']])
  end

  def test_state
    assert_equal(@resp.states,  [['test1']])
  end
end