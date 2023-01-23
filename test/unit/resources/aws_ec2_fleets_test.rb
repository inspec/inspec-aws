require 'helper'
require 'aws_ec2_fleets'
require 'aws-sdk-core'

class AWSEC2FleetsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2Fleets.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2Fleets.new('rubbish') }
  end

  def test_fleets_non_existing_for_empty_response
    refute AWSEC2Fleets.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2FleetsHappyPathTest < Minitest::Test

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
    data[:data] = { :fleets => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2Fleets.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_activity_statuses
    assert_equal(@resp.activity_statuses, ['test1'])
  end

  def test_create_times
    assert_equal(@resp.create_times, [Time.parse('2021-09-20 13:10:26.000000000 +0000')])
  end

  def test_fleet_ids
    assert_equal(@resp.fleet_ids, ['test1'])
  end

  def test_fleet_states
    assert_equal(@resp.fleet_states, ['test1'])
  end

  def test_client_tokens
    assert_equal(@resp.client_tokens, ['test1'])
  end

  def test_excess_capacity_termination_policies
    assert_equal(@resp.excess_capacity_termination_policies, ['test1'])
  end
end
