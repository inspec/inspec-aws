require 'aws-sdk-core'
require 'aws_iam_password_policy'
require 'helper'
require_relative 'mock/iam/aws_iam_password_policy_mock'

class AwsIamPasswordPolicyTest < Minitest::Test

  def setup
    # Given
    @mock = AwsIamPasswordPolicyMock.new
    @mock_policy = @mock.policy

    # When
    @policy = AwsIamPasswordPolicy.new(client_args: { stub_responses: true }, stub_data: @mock.stub_data)
  end

  def test_minimum_password_length
    assert_equal(@policy.minimum_password_length, @mock_policy[:minimum_password_length])
  end

  def test_max_password_age_in_days
    assert_equal(@policy.max_password_age_in_days, @mock_policy[:max_password_age])
  end

  def test_number_of_passwords_to_remember
    assert_equal(@policy.number_of_passwords_to_remember, @mock_policy[:password_reuse_prevention])
  end

  def test_require_symbols
    assert_equal(@policy.require_symbols?, @mock_policy[:require_symbols])
  end

  def test_require_numbers
    assert_equal(@policy.require_numbers?, @mock_policy[:require_numbers])
  end

  def test_require_uppercase_characters
    assert_equal(@policy.require_uppercase_characters?, @mock_policy[:require_uppercase_characters])
  end

  def test_require_lowercase_characters
    assert_equal(@policy.require_lowercase_characters?, @mock_policy[:require_lowercase_characters])
  end

  def test_allow_users_to_change_password
    assert_equal(@policy.allow_users_to_change_password?, @mock_policy[:allow_users_to_change_password])
  end

  def test_prevent_password_reuse?
    assert @policy.prevent_password_reuse?
  end

  def test_expire_passwords?
    assert_equal(@policy.expire_passwords?, @mock_policy[:hard_expiry])
  end

  def test_exists
    assert @policy.exists?
  end

end