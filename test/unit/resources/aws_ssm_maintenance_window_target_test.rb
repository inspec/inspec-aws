require 'helper'
require 'aws_ssm_maintenance_window_target'
require 'aws-sdk-core'

class AWSSESMaintenanceWindowTargetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSSESMaintenanceWindowTarget.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSSESMaintenanceWindowTarget.new(window_id: '', window_target_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSSESMaintenanceWindowTarget.new(unexpected: 9) }
  end
end

class AWSSESMaintenanceWindowTargetSuccessPathTest < Minitest::Test

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
    @resp = AWSSESMaintenanceWindowTarget.new(window_id: 'test1', window_target_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_targets_exist
    assert @resp.exists?
  end

  def test_window_id
    assert_equal(@resp.window_id, 'test1')
  end

  def test_window_target_id
    assert_equal(@resp.window_target_id, 'test1')
  end

  def test_resource_type
    assert_equal(@resp.resource_type, 'test1')
  end

  def test_owner_information
    assert_equal(@resp.owner_information, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end
end
