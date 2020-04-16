require 'helper'
require 'aws_efs_file_system'
require "aws-sdk-core"

class AwsEfsFileSystemConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEfsFileSystem.new() }
  end

  def test_integer_params_not_ok
    assert_raises(ArgumentError) { AwsEfsFileSystem.new(1234) }
  end

  def test_rejects_invalid_fs_id
    assert_raises(ArgumentError) { AwsEfsFileSystem.new('fs-123') }
  end

  def test_rejects_long_creation_token
    assert_raises(ArgumentError) { AwsEfsFileSystem.new(creation_token: 'a'*65) }
  end

  def test_rejects_unrecognized_identifiers
    assert_raises(ArgumentError) { AwsEfsFileSystem.new(fs_id: 'fs-12345678') }
  end

  def test_accepts_file_system_id_as_identifier
    assert AwsEfsFileSystem.new(file_system_id: 'fs-12345678')
  end

  def test_accepts_creation_token_as_identifier
    assert AwsEfsFileSystem.new(creation_token: 'my_token')
  end

  def test_file_system_non_existing_creation_token
    refute AwsEfsFileSystem.new(creation_token: 'my_token').exists?
  end

  def test_file_system_non_existing_fs_id
    refute AwsEfsFileSystem.new(file_system_id: 'fs-12345678').exists?
  end
end

class AwsEfsFileSystemTest < Minitest::Test
  def setup
    # Define required properties of a mock file system.
    @mock_fs = {}
    @mock_fs[:tags] = [{ :key => 'Name', :value => 'My EFS File System' }]
    @mock_fs[:file_system_id] = 'fs-12345678'
    @mock_fs[:creation_token] = 'my_token'
    @mock_fs[:owner_id] = '012345678912'
    @mock_fs[:creation_time] = Time.at(628232400)
    @mock_fs[:life_cycle_state] = 'available'
    @mock_fs[:number_of_mount_targets] = 1
    @mock_fs[:size_in_bytes] = { :value => 6144 }
    @mock_fs[:performance_mode] = 'generalPurpose'
    @mock_fs[:encrypted] = true
    @mock_fs[:throughput_mode] = 'bursting'

    # Create stub data in expected format.
    data = {}
    data[:data] = { :file_systems => [@mock_fs] }
    data[:client] = Aws::EFS::Client
    data[:method] = :describe_file_systems

    # Create a mock file system with stub data.
    @file_system = AwsEfsFileSystem.new(file_system_id: @mock_fs[:file_system_id], client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_file_system_exists
    assert @file_system.exists?
  end

  def test_file_system_name
    assert_equal(@file_system.tags['Name'], @mock_fs[:tags][0][:value])
  end

  def test_file_system_id
    assert_equal(@file_system.file_system_id, @mock_fs[:file_system_id])
  end

  def test_creation_token
    assert_equal(@file_system.creation_token, @mock_fs[:creation_token])
  end

  def test_owner_id
    assert_equal(@file_system.owner_id, @mock_fs[:owner_id])
  end

  def test_creation_time
    assert_equal(@file_system.creation_time, @mock_fs[:creation_time])
  end

  def test_life_cycle_state
    assert_equal(@file_system.life_cycle_state, @mock_fs[:life_cycle_state])
  end

  def test_size_in_bytes
    assert_equal(@file_system.size_in_bytes.value, @mock_fs[:size_in_bytes][:value])
  end

  def test_performance_mode
    assert_equal(@file_system.performance_mode, @mock_fs[:performance_mode])
  end

  def test_throughput_mode
    assert_equal(@file_system.throughput_mode, @mock_fs[:throughput_mode])
  end

  def test_encrypted
    assert_equal(@file_system.encrypted, @mock_fs[:encrypted])
  end
end



















