require 'aws-sdk-core'
require 'aws_iam_policy'
require 'helper'
require_relative 'mock/iam/aws_iam_policy_mock'


class AwsIamPolicyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsIamPolicy.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_policy_arn
    AwsIamPolicy.new(policy_arn: 'policy-arn', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsIamPolicy.new(rubbish: 9) }
  end
end

class AwsIamPolicyTest < Minitest::Test

  def setup
    # Given
    @mock = AwsIamPolicyMock.new
    @mock_policy = @mock.policy

    # When
    @policy= AwsIamPolicy.new(policy_arn: @mock_policy[:arn],
                           client_args: { stub_responses: true },
                           stub_data: @mock.stub_data)
  end

  def test_arn
    assert_equal(@policy.arn, @mock_policy[:arn])
  end

  def test_attached_username
    assert @policy.attached_to_user?((@mock_policy[:username]))
  end

  def test_attached_role
    assert @policy.attached_to_role?((@mock_policy[:rolename]))
  end

  def test_attachment_count
    assert_equal(@policy.attachment_count, @mock_policy[:attachment_count])
  end

  def test_default_version_id
    assert_equal(@policy.default_version_id, @mock_policy[:default_version_id])
  end

  def test_policy_name
    assert_equal(@policy.policy_name, @mock_policy[:policy_name])
  end

  def test_policy_id
    assert_equal(@policy.policy_id, @mock_policy[:policy_id])
  end

  def test_policy_attached_groups
    assert_equal(@policy.attached_groups, @mock_policy[:attached_groups])
  end

  def test_policy_attached_roles
    assert_equal(@policy.attached_roles.first, @mock_policy[:attached_roles].first[:role_name])
  end

  def test_policy_attached_user
    assert_equal(@policy.attached_users.first, @mock_policy[:attached_users].first[:user_name])
  end

  def test_statement_count
    assert_equal(@policy.statement_count, 2)
  end

  def test_exists
    assert @policy.exists?
  end

end
