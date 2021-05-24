require 'helper'
require 'aws-sdk-core'
require 'aws_ecr_repository_policy'
require_relative 'mock/aws_ecr_repository_policy_mock'

class AwsEcrPolicyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEcrPolicy.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_repository_name
    AwsEcrPolicy.new(repository_name:'repo-name', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsEcrPolicy.new(rubbish: 9) }
  end
end

class AwsEcrPolicyTest < Minitest::Test

  def setup
    # Given
    @mock = AwsEcrPolicyMock.new
    @mock_ecr_policy = @mock.policy

    # When
    @policy = AwsEcrPolicy.new(repository_name: @mock_ecr_policy[:repository_name],
                                 client_args: { stub_responses: true },
                                 stub_data: @mock.stub_data)
  end

  def test_exists
    assert @policy.exists?
  end

  def test_statment_contains_action
    assert @policy.policy_text.has_statement?(Effect: "Allow")
  end

  def test_statment_contains_action_existing_with_effect
    assert @policy.policy_text.has_statement?(Action: "ecr:BatchGetImage", Effect: "Allow")
  end

  def test_statment_contains_action_existing_with_effect_and_principal
    assert @policy.policy_text.has_statement?(Action: "ecr:BatchGetImage", Effect: "Allow", Principal: "*")
  end

  def test_statment_contains_all_principals
    assert @policy.policy_text.has_statement?(Principal: "*")
  end
end
