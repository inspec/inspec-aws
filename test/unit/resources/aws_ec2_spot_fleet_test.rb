require 'helper'
require 'aws_ec2_spot_fleet'
require 'aws-sdk-core'

class AWSEC2SpotFleetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2SpotFleet.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2SpotFleet.new(spot_fleet_request_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2SpotFleet.new(unexpected: 9) }
  end
end

class AWSEC2SpotFleetSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_spot_fleet_requests
    mock_data = {}
    mock_data[:activity_status] = 'test1'
    mock_data[:spot_fleet_request_id] = 'test1'
    mock_data[:spot_fleet_request_state] = 'test1'
    mock_data[:tags] = []
    data[:data] = { spot_fleet_request_configs: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2SpotFleet.new(spot_fleet_request_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_spot_fleet_request_configs_exists
    assert @resp.exists?
  end

  def test_activity_status
    assert_equal(@resp.activity_status,  'test1')
  end

  def test_spot_fleet_request_id
    assert_equal(@resp.spot_fleet_request_id,  'test1')
  end

  def test_spot_fleet_request_state
    assert_equal(@resp.spot_fleet_request_state,  'test1')
  end
end