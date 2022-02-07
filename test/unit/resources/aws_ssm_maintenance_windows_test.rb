require 'helper'
require 'aws_ssm_maintenance_windows'
require 'aws-sdk-core'

class AWSSESMaintenanceWindowsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSSESMaintenanceWindows.new(client_args: { stub_responses: true })
  end

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSESMaintenanceWindows.new(unexpected: 9, client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSESMaintenanceWindows.new(unexpected: 9) }
  end
end

class AWSSESMaintenanceWindowsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_maintenance_windows
    mock_data = {}
    mock_data[:window_id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:enabled] = true
    mock_data[:duration] = 1
    mock_data[:cutoff] = 1
    mock_data[:schedule] = 'test1'
    mock_data[:schedule_timezone] = 'test1'
    mock_data[:schedule_offset] = 1
    mock_data[:end_date] = 'test1'
    mock_data[:start_date] = 'test1'
    mock_data[:next_execution_time] = 'test1'
    data[:data] = { window_identities: [mock_data] }
    data[:client] = Aws::SES::Client
    @resp = AWSSESMaintenanceWindows.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def window_ids
    assert_equal(@resp.window_ids, ['test1'])
  end

  def names
    assert_equal(@resp.names, ['test1'])
  end

  def descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end

  def enabled
    assert_equal(@resp.enabled, [true])
  end

  def durations
    assert_equal(@resp.durations, [1])
  end

  def cutoffs
    assert_equal(@resp.cutoffs, [1])
  end

  def schedules
    assert_equal(@resp.schedules, ['test1'])
  end

  def schedule_timezones
    assert_equal(@resp.schedule_timezones, ['test1'])
  end

  def schedule_offsets
    assert_equal(@resp.schedule_offsets, [1])
  end

  def end_dates
    assert_equal(@resp.end_dates, ['test1'])
  end

  def start_dates
    assert_equal(@resp.start_dates, ['test1'])
  end

  def next_execution_times
    assert_equal(@resp.next_execution_times, ['test1'])
  end
end