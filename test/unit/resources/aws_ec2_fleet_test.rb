require 'helper'
require 'aws_ec2_fleet'
require 'aws-sdk-core'

class AWSEC2FleetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2Fleet.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2Fleet.new(fleet_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2Fleet.new(unexpected: 9) }
  end
end

class AWSEC2FleetSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_fleets
    mock_data = {}
    mock_data[:activity_status] = 'test1'
    mock_data[:create_time] = Time.parse('2021-09-20 13:10:26.000000000 +0000')
    mock_data[:fleet_id] = 'test1'
    mock_data[:fleet_state] = 'test1'
    mock_data[:client_token] = 'test1'
    mock_data[:excess_capacity_termination_policy] = 'test1'
    mock_data[:fulfilled_capacity] = 1.0
    mock_data[:fulfilled_on_demand_capacity] = 1.0
    data[:data] = { fleets: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2Fleet.new(fleet_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_fleets_exists
    assert @resp.exists?
  end

  def test_activity_status
    assert_equal(@resp.activity_status, 'test1')
  end

  def test_create_time
    assert_equal(@resp.create_time, Time.parse('2021-09-20 13:10:26.000000000 +0000'))
  end

  def test_fleet_id
    assert_equal(@resp.fleet_id, 'test1')
  end

  def test_fleet_state
    assert_equal(@resp.fleet_state, 'test1')
  end

  def test_client_token
    assert_equal(@resp.client_token, 'test1')
  end

  def test_excess_capacity_termination_policy
    assert_equal(@resp.excess_capacity_termination_policy, 'test1')
  end
end
