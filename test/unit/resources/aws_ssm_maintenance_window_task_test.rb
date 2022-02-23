require 'helper'
require 'aws_ssm_maintenance_window_task'
require 'aws-sdk-core'

class AWSSESMaintenanceWindowTaskConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSSESMaintenanceWindowTask.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSESMaintenanceWindowTask.new(window_id: '', window_task_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSESMaintenanceWindowTask.new(unexpected: 9) }
  end
end

class AWSSESMaintenanceWindowTaskSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_maintenance_window_tasks
    mock_data = {}
    mock_data[:window_id] = 'test1'
    mock_data[:window_task_id] = 'test1'
    mock_data[:task_arn] = 'test1'
    mock_data[:type] = 'test1'
    mock_data[:priority] = 1
    mock_data[:max_errors] = '1'
    mock_data[:name] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:cutoff_behavior] = 'test1'
    data[:data] = { tasks: [mock_data] }
    data[:client] = Aws::SSM::Client
    @resp = AWSSESMaintenanceWindowTask.new(window_id: 'test1', window_task_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_tasks_exist
    assert @resp.exists?
  end

  def test_window_id
    assert_equal(@resp.window_id, 'test1')
  end

  def test_window_task_id
    assert_equal(@resp.window_task_id, 'test1')
  end

  def test_task_arn
    assert_equal(@resp.task_arn, 'test1')
  end

  def test_type
    assert_equal(@resp.type, 'test1')
  end

  def test_priority
    assert_equal(@resp.priority, 1)
  end

  def test_max_errors
    assert_equal(@resp.max_errors, '1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_cutoff_behavior
    assert_equal(@resp.cutoff_behavior, 'test1')
  end
end
