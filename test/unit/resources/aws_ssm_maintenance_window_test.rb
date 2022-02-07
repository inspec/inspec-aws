require 'helper'
require 'aws_ssm_maintenance_window'
require 'aws-sdk-core'

class AWSSESMaintenanceWindowConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSSESMaintenanceWindow.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSESMaintenanceWindow.new(window_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSESMaintenanceWindow.new(unexpected: 9) }
  end
end

class AWSSESMaintenanceWindowSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_maintenance_window
    mock_data = {}
    mock_data[:window_id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:start_date] = 'test1'
    mock_data[:end_date] = 'test1'
    mock_data[:schedule] = 'test1'
    mock_data[:schedule_timezone] = 'test1'
    mock_data[:schedule_offset] = 1
    mock_data[:next_execution_time] = 'test1'
    mock_data[:duration] = 1
    mock_data[:cutoff] = 1
    mock_data[:allow_unassociated_targets] = true
    mock_data[:enabled] = true
    data[:data] = mock_data
    data[:client] = Aws::SSM::Client
    @resp = AWSSESMaintenanceWindow.new(window_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_maintenance_window_exist
    assert @resp.exists?
  end

  def test_window_id
    assert_equal(@resp.window_id, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_start_date
    assert_equal(@resp.start_date, 'test1')
  end

  def test_end_date
    assert_equal(@resp.end_date, 'test1')
  end

  def test_schedule
    assert_equal(@resp.schedule, 'test1')
  end

  def test_schedule_timezone
    assert_equal(@resp.schedule_timezone, 'test1')
  end

  def test_schedule_offset
    assert_equal(@resp.schedule_offset, 1)
  end

  def test_next_execution_time
    assert_equal(@resp.next_execution_time, 'test1')
  end

  def test_duration
    assert_equal(@resp.duration, 1)
  end

  def test_cutoff
    assert_equal(@resp.cutoff, 1)
  end

  def test_allow_unassociated_targets
    assert_equal(@resp.allow_unassociated_targets, true)
  end

  def test_enabled
    assert_equal(@resp.enabled, true)
  end
end
