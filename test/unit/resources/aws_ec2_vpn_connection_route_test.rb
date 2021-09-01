require 'helper'
require 'aws_ec2_vpn_connection_route'
require 'aws-sdk-core'

class AWSEC2VPNConnectionRouteConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2VPNConnectionRoute.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2VPNConnectionRoute.new(vpn_connection_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2VPNConnectionRoute.new(unexpected: 9) }
  end
end

class AWSEC2VPNConnectionRouteSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_vpn_connections
    mock_data = {}
    mock_data[:routes] = [{
                            destination_cidr_block: 'test1',
                            source: 'test1',
                            state: 'test1'
                          }]
    data[:data] = { vpn_connections: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2VPNConnectionRoute.new(vpn_connection_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpn_connections_configs_exists
    assert @resp.exists?
  end

  def test_destination_cidr_block
    assert_equal(@resp.destination_cidr_block,  'test1')
  end

  def test_source
    assert_equal(@resp.source,  'test1')
  end

  def test_state
    assert_equal(@resp.state,  'test1')
  end
end