require 'helper'
require 'aws_efs_file_system'
require "aws-sdk-core"
require_relative 'mock/aws_efs_file_system_mock'

class AwsEfsFileSystemConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEfsFileSystem.new() }
  end

  def test_integer_params_not_ok
    assert_raises(ArgumentError) { AwsEfsFileSystem.new(1234) }
  end

  def test_rejects_invalid_f_s_id
    assert_raises(ArgumentError) { AwsEfsFileSystem.new('f_s-123') }
  end

  def test_rejects_long_creation_token
    assert_raises(ArgumentError) { AwsEfsFileSystem.new(creation_token: 'a'*65) }
  end

  def test_rejects_unrecognized_identifiers
    assert_raises(ArgumentError) { AwsEfsFileSystem.new(rubbish_id: 'fs-12345678') }
  end

  def test_accepts_file_system_id_as_identifier
    assert AwsEfsFileSystem.new(file_system_id: 'fs-12345678', client_args: { stub_responses: true })
  end

  def test_accepts_creation_token_as_identifier
    assert AwsEfsFileSystem.new(creation_token: 'my_token', client_args: { stub_responses: true })
  end

  def test_file_system_non_existing_creation_token
    refute AwsEfsFileSystem.new(creation_token: 'my_token', client_args: { stub_responses: true }).exists?
  end

  def test_file_system_non_existing_f_s_id
    refute AwsEfsFileSystem.new(file_system_id: 'fs-12345678', client_args: { stub_responses: true }).exists?
  end
end

class AwsEfsFileSystemTest < Minitest::Test

  def setup
    # Create a mock file system
    number_of_fs = 1
    @mock_file_system_list = AwsEfsFileSystemMock.new.multiple(number_of_fs)

    # Create stub data.
    data = {}
    data[:data] = { :file_systems => @mock_file_system_list }
    data[:client] = Aws::EFS::Client
    data[:method] = :describe_file_systems

    # This is for brevity.
    @m_f_s = @mock_file_system_list.first

    # Create a stub file system description with mock file system data.
    @file_system = AwsEfsFileSystem.new(
        file_system_id: @m_f_s[:file_system_id],
        client_args: { stub_responses: true },
        stub_data: [data]
    )
  end

  def test_file_system_exists
    assert @file_system.exists?
  end

  def test_file_system_tag
    assert_equal(@file_system.tags[@m_f_s[:tags][0][:key]], @m_f_s[:tags][0][:value])
  end

  def test_file_system_id
    assert_equal(@file_system.file_system_id, @m_f_s[:file_system_id])
  end

  def test_creation_token
    assert_equal(@file_system.creation_token, @m_f_s[:creation_token])
  end

  def test_owner_id
    assert_equal(@file_system.owner_id, @m_f_s[:owner_id])
  end

  def test_creation_time
    assert_equal(@file_system.creation_time, @m_f_s[:creation_time])
  end

  def test_life_cycle_state
    assert_equal(@file_system.life_cycle_state, @m_f_s[:life_cycle_state])
  end

  def test_size_in_bytes
    assert_equal(@file_system.size_in_bytes.value, @m_f_s[:size_in_bytes][:value])
  end

  def test_performance_mode
    assert_equal(@file_system.performance_mode, @m_f_s[:performance_mode])
  end

  def test_throughput_mode
    assert_equal(@file_system.throughput_mode, @m_f_s[:throughput_mode])
  end

  def test_encrypted
    assert_equal(@file_system.encrypted, @m_f_s[:encrypted])
  end
end
