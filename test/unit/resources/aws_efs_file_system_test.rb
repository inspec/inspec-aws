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
    # Declare instance variables
    @file_system_name = 'My EFS File System'
    @file_system_id = 'fs-12345678'
    @creation_token = 'my_token'
    @owner_id = '012345678912'
    @creation_time = Time.at(628232400)
    @life_cycle_state = 'available'
    @number_of_mount_targets = 1
    @size_in_bytes_value = 6144
    size_in_bytes = { :value => @size_in_bytes_value }
    @performance_mode = 'generalPurpose'
    @encrypted = true
    @throughput_mode = 'bursting'
    # Prepare stub data
    mock_file_system = {}
    mock_file_system[:tags] = [{ :key => 'Name', :value => @file_system_name }]
    mock_file_system[:file_system_id] = @file_system_id
    mock_file_system[:creation_token] = @creation_token
    mock_file_system[:owner_id] = @owner_id
    mock_file_system[:creation_time] = @creation_time
    mock_file_system[:life_cycle_state] = @life_cycle_state
    mock_file_system[:number_of_mount_targets] = @number_of_mount_targets
    mock_file_system[:size_in_bytes] = size_in_bytes
    mock_file_system[:performance_mode] = @performance_mode
    mock_file_system[:encrypted] = @encrypted
    mock_file_system[:throughput_mode] = @throughput_mode
    data = {}
    data[:data] = { :file_systems => [mock_file_system] }
    data[:client] = Aws::EFS::Client
    data[:method] = :describe_file_systems
    @file_system = AwsEfsFileSystem.new(file_system_id: @file_system_id, client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_file_system_exists
    assert @file_system.exists?
  end

  def test_file_system_name
    assert_equal(@file_system.tags['Name'], @file_system_name)
  end

  def test_file_system_id
    assert_equal(@file_system.file_system_id, @file_system_id)
  end

  def test_creation_token
    assert_equal(@file_system.creation_token, @creation_token)
  end

  def test_owner_id
    assert_equal(@file_system.owner_id, @owner_id)
  end

  def test_creation_time
    assert_equal(@file_system.creation_time, @creation_time)
  end

  def test_life_cycle_state
    assert_equal(@file_system.life_cycle_state, @life_cycle_state)
  end

  def test_size_in_bytes
    assert_equal(@file_system.size_in_bytes.value, @size_in_bytes_value)
  end

  def test_performance_mode
    assert_equal(@file_system.performance_mode, @performance_mode)
  end

  def test_throughput_mode
    assert_equal(@file_system.throughput_mode, @throughput_mode)
  end

  def test_encrypted
    assert_equal(@file_system.encrypted, @encrypted)
  end
end


















