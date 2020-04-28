require 'helper'
require 'aws_efs_file_systems'
require "aws-sdk-core"
require_relative 'aws_efs_file_system_test'

class AwsEfsFileSystemsConstructorTest < Minitest::Test

  def test_empty_params_ok
    assert AwsEfsFileSystems.new(client_args: { stub_responses: true })
  end

  def test_reject_other_args
    assert_raises(ArgumentError) { AwsEfsFileSystems.new('rubbish') }
  end

  def test_file_systems_non_existing_for_empty_response
    refute AwsEfsFileSystems.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsEfsFileSystemsTest < Minitest::Test

  def setup(number_of_fs = 5)
    # Create a number of mock file systems {default - 5}
    @mock_file_system_list = AwsEfsFileSystemMock.new.multiple(number_of_fs)

    # Create stub data.
    data = {}
    data[:data] = { :file_systems => @mock_file_system_list }
    data[:client] = Aws::EFS::Client
    data[:method] = :describe_file_systems

    # Create a stub file systems description with mock file systems.
    @file_system_list = AwsEfsFileSystems.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_file_system_exists
    assert @file_system_list.exist?
  end

  def test_file_system_tag
    @file_system_list.tags.zip(@mock_file_system_list).each do |f_s_t, m_f_s|
      assert_equal(f_s_t[0][:key], m_f_s[:tags][0][:key])
      assert_equal(f_s_t[0][:value], m_f_s[:tags][0][:value])
    end
  end

  def test_file_system_id
    @file_system_list.file_system_ids.zip(@mock_file_system_list).each do |f_s_i, m_f_s|
      assert_equal(f_s_i, m_f_s[:file_system_id])
    end
  end

  def test_creation_token
    @file_system_list.creation_tokens.zip(@mock_file_system_list).each do |f_s_c, m_f_s|
      assert_equal(f_s_c, m_f_s[:creation_token])
    end
  end

  def test_owner_id
    @file_system_list.owner_ids.zip(@mock_file_system_list).each do |f_s_o, m_f_s|
      assert_equal(f_s_o, m_f_s[:owner_id])
    end
  end

  def test_creation_time
    @file_system_list.creation_times.zip(@mock_file_system_list).each do |f_s_c, m_f_s|
      assert_equal(f_s_c, m_f_s[:creation_time])
    end
  end

  def test_life_cycle_state
    @file_system_list.life_cycle_states.zip(@mock_file_system_list).each do |f_s_l, m_f_s|
      assert_equal(f_s_l, m_f_s[:life_cycle_state])
    end
  end

  def test_size_in_bytes
    @file_system_list.size_in_bytes.zip(@mock_file_system_list).each do |f_s_s, m_f_s|
      assert_equal(f_s_s.value, m_f_s[:size_in_bytes][:value])
    end
  end

  def test_performance_mode
    @file_system_list.performance_modes.zip(@mock_file_system_list).each do |f_s_p, m_f_s|
      assert_equal(f_s_p, m_f_s[:performance_mode])
    end

  end

  def test_throughput_mode
    @file_system_list.throughput_modes.zip(@mock_file_system_list).each do |f_s_t, m_f_s|
      assert_equal(f_s_t, m_f_s[:throughput_mode])
    end
  end

  def test_encrypted
    @file_system_list.encryption_status.zip(@mock_file_system_list).each do |f_s_e, m_f_s|
      assert_equal(f_s_e, m_f_s[:encrypted])
    end
  end
end
