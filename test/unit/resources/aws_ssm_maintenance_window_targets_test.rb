require 'helper'
require 'aws_ssm_maintenance_window_targets'
require 'aws-sdk-core'

class AWSSESMaintenanceWindowTargetsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSSESMaintenanceWindowTargets.new(window_id: 'test1', client_args: { stub_responses: true })
  end

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSESMaintenanceWindowTargets.new(unexpected: 9, client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSESMaintenanceWindowTargets.new(unexpected: 9) }
  end
end

class AWSSESMaintenanceWindowTargetsSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_maintenance_window_targets
    mock_data = {}
    mock_data[:window_id] = 'test1'
    mock_data[:window_target_id] = 'test1'
    mock_data[:resource_type] = 'test1'
    mock_data[:owner_information] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:description] = 'test1'
    data[:data] = { targets: [mock_data] }
    data[:client] = Aws::SSM::Client
    @resp = AWSSESMaintenanceWindowTargets.new(window_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_window_ids
    assert_equal(@resp.window_ids, ['test1'])
  end

  def test_window_target_ids
    assert_equal(@resp.window_target_ids, ['test1'])
  end

  def test_resource_types
    assert_equal(@resp.resource_types, ['test1'])
  end

  def test_owner_informations
    assert_equal(@resp.owner_informations, ['test1'])
  end

  def test_names
    assert_equal(@resp.names, ['test1'])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test1'])
  end
end