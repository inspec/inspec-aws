require 'aws-sdk-core'
require 'aws_iam_root_user'
require 'helper'
require_relative 'mock/iam/aws_iam_root_user_mock'

class AwsIamRootUserTest < Minitest::Test

  def setup
    # Given
    @mock                 = AwsIamRootUserMock.new
    @mock_summary         = @mock.summary
    @mock_virtual_devices = @mock.virtual_devices

    # When
    @root_user = AwsIamRootUser.new(client_args: { stub_responses: true }, stub_data: @mock.stub_data)
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsIamRootUser.new(failure_option: true) }
  end

  def test_has_access_key
    assert_equal(@root_user.has_access_key?, @mock_summary['AccountAccessKeysPresent'] == 1)
  end

  def test_has_mfa_enabled
    assert_equal(@root_user.has_mfa_enabled?, @mock_summary['AccountMFAEnabled'] == 1)
  end

  def test_has_hardware_mfa_enabled
    virtual_mfa_suffix = 'root-account-mfa-device'
    virtual_mfa_enabled = @mock_virtual_devices.any? { |device| device[:serial_number].end_with?(virtual_mfa_suffix)}
    assert_equal(@root_user.has_hardware_mfa_enabled?, (@mock_summary['AccountMFAEnabled'] == 1 && !virtual_mfa_enabled))
  end

  def test_exists
    assert(@root_user.exists?)
  end


end