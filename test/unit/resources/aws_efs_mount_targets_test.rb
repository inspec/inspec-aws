require 'helper'
require 'aws_efs_mount_targets'
require 'aws-sdk-core'
require_relative 'aws_efs_mount_target_test'

class AWSEFSMountTargetsConstructorTest < Minitest::Test

  def test_reject_other_args
    assert_raises(ArgumentError) { AWSEFSMountTargets.new('rubbish') }
  end
end

class AWSEFSMountTargetsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_mount_targets
    mock_parameter = {}
    mock_parameter[:owner_id] = 'test1'
    mock_parameter[:mount_target_id] = 'test1'
    mock_parameter[:file_system_id] = 'test1'
    mock_parameter[:subnet_id] = 'test1'
    mock_parameter[:life_cycle_state] = 'test1'
    data[:data] = { :mount_targets => [mock_parameter] }
    data[:client] = Aws::EFS::Client
    @mount_targets = AWSEFSMountTargets.new(file_system_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_mount_targets_exists
    assert @mount_targets.exist?
  end

  def test_owner_ids
    assert_equal(@mount_targets.owner_ids, ['test1'])
  end

  def test_mount_target_ids
    assert_equal(@mount_targets.mount_target_ids, ['test1'])
  end

  def test_file_system_ids
    assert_equal(@mount_targets.file_system_ids, ['test1'])
  end
end