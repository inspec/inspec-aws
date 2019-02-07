require 'aws-sdk-core'
require 'aws_iam_user'
require 'helper'
require_relative 'mock/iam/aws_iam_user_mock'

class AwsIamUserTest < Minitest::Test

  def setup
    # Given
    @mock = AwsIamUserMock.new
    @mock_user = @mock.user

    # When
    @user = AwsIamUser.new(user_name: @mock_user[:user_name],
                           client_args: { stub_responses: true },
                           stub_data: @mock.stub_data)
  end

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsIamUser.new(client_args: { stub_responses: true }) }
  end

  def test_user_name
    assert_equal(@user.username, @mock_user[:user_name])
  end

  def test_user_id
    assert_equal(@user.user_id, @mock_user[:user_id])
  end

  def test_user_arn
    assert_equal(@user.user_arn, @mock_user[:arn])
  end

  def test_access_keys
    assert_equal(@user.access_keys, @mock_user[:access_keys])
  end

  def test_has_mfa_enabled
    assert @user.has_mfa_enabled
  end

  def test_attached_policy_names
    assert_equal(@user.attached_policy_names, @mock_user[:attached_policy_names])
  end

  def test_attached_policy_arns
    assert_equal(@user.attached_policy_arns, @mock_user[:attached_policy_arns])
  end

  def test_has_console_password
    assert @user.has_console_password
  end

  def test_inline_policy_names
    assert_equal(@user.inline_policy_names, @mock_user[:inline_policy_names])
  end

  def test_exists
    assert @user.exists?
  end

end