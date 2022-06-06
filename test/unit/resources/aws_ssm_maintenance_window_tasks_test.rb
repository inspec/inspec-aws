require 'helper'
require 'aws_ssm_maintenance_window_tasks'
require 'aws-sdk-core'

class AWSSESMaintenanceWindowTasksConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSSESMaintenanceWindowTasks.new(window_id: 'test1', client_args: { stub_responses: true })
  end

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSESMaintenanceWindowTasks.new(unexpected: 9, client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSESMaintenanceWindowTasks.new(unexpected: 9) }
  end
end

class AWSSESMaintenanceWindowTasksSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_maintenance_window_tasks
    mock_data = {}
    mock_data[:window_id] = 'test1'
    mock_data[:window_task_id] = 'test1'
    mock_data[:task_arn] = 'test1'
    mock_data[:type] = 'test1'
    mock_data[:priority] = 1
    mock_data[:service_role_arn] = 'test1'
    mock_data[:max_concurrency] = '1'
    mock_data[:max_errors] = '1'
    mock_data[:name] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:cutoff_behavior] = 'test1'
    data[:data] = { tasks: [mock_data] }
    data[:client] = Aws::SSM::Client
    @resp = AWSSESMaintenanceWindowTasks.new(window_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_window_ids
    assert_equal(@resp.window_ids, ['test1'])
  end

  def test_window_task_ids
    assert_equal(@resp.window_task_ids, ['test1'])
  end

  def test_task_arns
    assert_equal(@resp.task_arns, ['test1'])
  end

  def test_types
    assert_equal(@resp.types, ['test1'])
  end

  def test_priorities
    assert_equal(@resp.priorities, [1])
  end

  def test_service_role_arns
    assert_equal(@resp.service_role_arns, ['test1'])
  end

  def test_max_concurrencies
    assert_equal(@resp.max_concurrencies, ['1'])
  end

  def test_max_errors
    assert_equal(@resp.max_errors, ['1'])
  end

  def test_names
    assert_equal(@resp.names, ['test1'])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end

  def test_cutoff_behaviors
    assert_equal(@resp.cutoff_behaviors, ['test1'])
  end
end