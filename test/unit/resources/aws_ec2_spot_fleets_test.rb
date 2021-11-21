require 'helper'
require 'aws_ec2_spot_fleets'
require 'aws-sdk-core'

class AWSEC2SpotFleetsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2SpotFleets.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2SpotFleets.new('rubbish') }
  end

  def test_spot_fleet_request_configs_non_existing_for_empty_response
    refute AWSEC2SpotFleets.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2SpotFleetsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_spot_fleet_requests
    mock_data = {}
    mock_data[:activity_status] = 'test1'
    mock_data[:spot_fleet_request_id] = 'test1'
    mock_data[:spot_fleet_request_state] = 'test1'
    mock_data[:tags] = []
    data[:data] = { :spot_fleet_request_configs => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2SpotFleets.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_activity_statuses
    assert_equal(@resp.activity_statuses,  ['test1'])
  end

  def test_spot_fleet_request_ids
    assert_equal(@resp.spot_fleet_request_ids,  ['test1'])
  end

  def test_spot_fleet_request_states
    assert_equal(@resp.spot_fleet_request_states,  ['test1'])
  end
end