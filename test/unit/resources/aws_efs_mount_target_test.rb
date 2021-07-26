require 'helper'
require 'aws_efs_mount_target'
require 'aws-sdk-core'

class AWSEFSMountTargetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEFSMountTarget.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEFSMountTarget.new(mount_target_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEFSMountTarget.new(unexpected: 9) }
  end
end

class AWSEFSMountTargetSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_mount_targets
    mock_parameter = {}
    mock_parameter[:owner_id] = 'test1'
    mock_parameter[:mount_target_id] = 'test1'
    mock_parameter[:file_system_id] = 'test1'
    mock_parameter[:subnet_id] = 'test1'
    mock_parameter[:life_cycle_state] = 'test1'
    data[:data] = { mount_targets: [mock_parameter] }
    data[:client] = Aws::EFS::Client
    @mount_targets = AWSEFSMountTarget.new(mount_target_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_mount_targets_exists
    assert @mount_targets.exists?
  end

  def test_owner_id
    assert_equal(@mount_targets.owner_id, 'test1')
  end

  def test_mount_target_id
    assert_equal(@mount_targets.mount_target_id, 'test1')
  end

  def test_file_system_id
    assert_equal(@mount_targets.file_system_id, 'test1')
  end

  def test_subnet_id
    assert_equal(@mount_targets.subnet_id, 'test1')
  end

  def test_life_cycle_state
    assert_equal(@mount_targets.life_cycle_state, 'test1')
  end
end