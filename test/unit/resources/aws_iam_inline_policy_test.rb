require 'aws-sdk-core'
require 'aws_iam_inline_policy'
require 'helper'
require_relative 'mock/iam/aws_iam_inline_policy_mock'


class AwsIamInlinePolicyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsIamInlinePolicy.new(client_args: { stub_responses: true }) }
  end

  def test_required_any_params_not_ok
    assert_raises(ArgumentError) { AwsIamInlinePolicy.new(policy_name: 'policy-name', client_args: { stub_responses: true }) }
  end

  def test_accepts_policy_name_and_role_name
    AwsIamInlinePolicy.new(policy_name: 'policy-arn', role_name: 'role-name', client_args: { stub_responses: true })
  end

  def test_accepts_policy_name_and_group_name
    AwsIamInlinePolicy.new(policy_name: 'policy-arn', group_name: 'group-name', client_args: { stub_responses: true })
  end

  def test_accepts_policy_name_and_user_name
    AwsIamInlinePolicy.new(policy_name: 'policy-arn', user_name: 'user-name', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsIamInlinePolicy.new(rubbish: 9) }
  end
end

class AwsIamInlinePolicyTest < Minitest::Test

  def setup
    # Given
    @mock = AwsIamInlinePolicyMock.new
    @mock_policy = @mock.policy

    # When
    @policy= AwsIamInlinePolicy.new(role_name:  @mock_policy[:role_name],
                           policy_name: @mock_policy[:policy_name],
                           client_args: { stub_responses: true },
                           stub_data: @mock.stub_data)
  end

  def test_policy_name
    assert_equal(@policy.policy_name, @mock_policy[:policy_name])
  end

  def test_statement_count
    assert_equal(@policy.statement_count, 2)
  end

  def test_exists
    assert @policy.exists?
  end

  def test_statement_contains_action
    assert @policy.has_statement?(Action: "ec2:Describe*")
  end

  def test_statment_contains_action_existing_with_effect
    assert @policy.has_statement?(Action: "ec2:Describe*", Effect: "Allow")
  end

  def test_statment_contains_action_existing_with_effect_and_resource
    assert @policy.has_statement?(Action: "ec2:Describe*", Effect: "Allow", Resource: "*")
  end

  def test_statment_contains_not_action
    assert @policy.has_statement?(NotAction: "s3:DeleteBucket")
  end

  def test_statment_contains_not_action_existing_with_effect
    assert @policy.has_statement?(NotAction: "s3:DeleteBucket", Effect: "Allow")
  end

  def test_statment_contains_without_not_action
    assert @policy.has_statement?(Effect: "Allow", Resource: "arn:aws:s3:::*")
  end

  def test_statement_full_match
    assert @policy.has_statement?(NotAction: "s3:DeleteBucket", Effect: "Allow", Resource: "arn:aws:s3:::*")
  end

  def test_statement_wrong_action
    refute @policy.has_statement?(Action: "s3:DeleteBucket", Effect: "Allow", Resource: "arn:aws:s3:::*")
  end

  def test_statment_contains_all_resources
    assert @policy.has_statement?(Resource: "*")
  end

  def test_statment_wrong_resource
    refute @policy.has_statement?(Resource: "arn:aws:ec2:::*")
  end
end
