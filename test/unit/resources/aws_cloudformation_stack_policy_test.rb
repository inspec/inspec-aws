require 'aws-sdk-core'
require 'aws_cloudformation_stack_policy'
require 'helper'
require_relative 'mock/aws_cloudformation_stack_policy_mock'


class AwsCloudformationStackPolicyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsCloudformationStackPolicy.new(client_args: { stub_responses: true }) }
  end

  def test_required_any_params_not_ok
    assert_raises(ArgumentError) { AwsCloudformationStackPolicy.new(stack_name: 'stack-name', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudformationStackPolicy.new(rubbish: 9) }
  end
end

class AwsCloudformationStackPolicyTest < Minitest::Test

  def setup
    # Given
    @mock = AwsCloudformationStackPolicyMock.new
    @mock_stack = @mock.stack

    # When
    @stack = AwsCloudformationStackPolicy.new(stack_name:  @mock_stack[:stack_name],
                                         client_args: { stub_responses: true },
                                         stub_data: @mock.stub_data)
  end

  def test_stack_name
    assert_equal(@stack.stack_name, @mock_stack[:stack_name])
  end

  def test_statement_count
    assert_equal(@stack.statement_count, 2)
  end

  def test_exists
    assert @stack.exists?
  end

  def test_statement_contains_action
    assert @stack.has_statement?(Action: "Update:*")
  end

  def test_statment_contains_action_existing_with_effect
    assert @stack.has_statement?(Action: "Update:*", Effect: "Allow")
  end

  def test_statment_contains_action_existing_with_effect_and_resource
    assert @stack.has_statement?(Action: "Update:*", Effect: "Allow", Resource: "*")
  end

  def test_statement_wrong_action
    refute @stack.has_statement?(NotAction: "Update:*", Effect: "Allow", Resource: "*")
  end
end
