require 'helper'
require 'aws_config_recorder'
require 'aws-sdk-core'

class AwsConfigurationRecorderConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsConfigurationRecorder.new(client_args: { stub_responses: true })
  end

  def test_accepts_config_recorder_name
    AwsConfigurationRecorder.new(recorder_name: 'config_recorder-1234abcd', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsConfigurationRecorder.new(rubbish: 9) }
  end

  def test_config_recorder_non_existing
    refute AwsConfigurationRecorder.new(recorder_name: 'config_recorder-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsConfigurationRecorderPositiveTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_configuration_recorders
    mock_config_recorder = {}
    mock_config_recorder[:name] = 'recorder'
    mock_config_recorder[:role_arn] = 'arn:aws:iam:::role/role'
    mock_config_recorder[:recording_group] = {}
    mock_config_recorder[:recording_group][:all_supported] = true
    mock_config_recorder[:recording_group][:include_global_resource_types] = true
    mock_config_recorder[:recording_group][:resource_types] = ['AWS::EC2::CustomerGateway', 'AWS::EC2::EIP']
    data[:data] = { :configuration_recorders => [mock_config_recorder] }
    data[:client] = Aws::ConfigService::Client
    status = {}
    status[:method] = :describe_configuration_recorder_status
    status[:data] = { :configuration_recorders_status => [{ :recording => true }] }
    status[:client] = Aws::ConfigService::Client
    @config_recorder = AwsConfigurationRecorder.new(recorder_name: 'recorder', client_args: { stub_responses: true }, stub_data: [data, status])
  end

  def test_config_recorder_exists
    assert @config_recorder.exists?
  end

  def test_config_recorder_role_arn
    assert_equal(@config_recorder.role_arn, 'arn:aws:iam:::role/role')
  end

  def test_config_recorder_resource_types
    assert_equal(@config_recorder.resource_types, ['AWS::EC2::CustomerGateway', 'AWS::EC2::EIP'])
  end

  def test_config_recorder_name
    assert_equal(@config_recorder.recorder_name, 'recorder')
  end

  def test_config_recorder_recording
    assert @config_recorder.recording?
  end

  def test_config_recorder_recording_all_resource_types
    assert @config_recorder.recording_all_resource_types?
  end

  def test_config_recorder_recording_all_global_types
    assert @config_recorder.recording_all_resource_types?
  end
end

class AwsConfigurationRecorderNegativeTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_configuration_recorders
    mock_config_recorder = {}
    mock_config_recorder[:name] = 'recorder'
    mock_config_recorder[:role_arn] = 'arn:aws:iam:::role/role'
    mock_config_recorder[:recording_group] = {}
    mock_config_recorder[:recording_group][:all_supported] = false
    mock_config_recorder[:recording_group][:include_global_resource_types] = false
    mock_config_recorder[:recording_group][:resource_types] = ['AWS::EC2::CustomerGateway', 'AWS::EC2::EIP']
    data[:data] = { :configuration_recorders => [mock_config_recorder] }
    data[:client] = Aws::ConfigService::Client
    status = {}
    status[:method] = :describe_configuration_recorder_status
    status[:data] = { :configuration_recorders_status => [{ :recording => false }] }
    status[:client] = Aws::ConfigService::Client
    @config_recorder = AwsConfigurationRecorder.new(recorder_name: 'recorder', client_args: { stub_responses: true }, stub_data: [data, status])
  end

  def test_config_recorder_exists
    assert @config_recorder.exists?
  end

  def test_config_recorder_role_arn
    assert_equal(@config_recorder.role_arn, 'arn:aws:iam:::role/role')
  end

  def test_config_recorder_resource_types
    assert_equal(@config_recorder.resource_types, ['AWS::EC2::CustomerGateway', 'AWS::EC2::EIP'])
  end

  def test_config_recorder_name
    assert_equal(@config_recorder.recorder_name, 'recorder')
  end

  def test_config_recorder_recording
    refute @config_recorder.recording?
  end

  def test_config_recorder_recording_all_resource_types
    refute @config_recorder.recording_all_resource_types?
  end

  def test_config_recorder_recording_all_global_types
    refute @config_recorder.recording_all_resource_types?
  end
end