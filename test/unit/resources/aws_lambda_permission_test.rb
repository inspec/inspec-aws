require 'helper'
require 'aws_lambda_permission'
require 'aws-sdk-core'

class AWSLambdaPermissionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSLambdaPermission.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSLambdaPermission.new(function_name: '', Sid: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSLambdaPermission.new(unexpected: 9) }
  end
end

class AWSLambdaPermissionSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_policy

    mock_data = "{\"Version\":\"2012-10-17\",\"Id\":\"default\",\"Statement\":[{\"Sid\":\"AllowExecutionFromSqs\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"sqs.amazonaws.com\"},\"Action\":\"lambda:InvokeFunction\",\"Resource\":\"arn:aws:lambda:us-east-2:112758395563:function:test_Lambda\",\"Condition\":{\"ArnLike\":{\"AWS:SourceArn\":\"arn:aws:sqs:us-east-2:112758395563:terraform-example-queue\"}}}]}"

    # mock_data[:policy] = JSON.parse("{test1}")
    # mock_data[:policy] = JSON.parse("test1")
    # mock_data[:effect] = 'test1'
    # mock_data[:principal] = 'test1'
    # mock_data[:action] = 'test1'
    # mock_data[:resource] = 'test1'
    data[:data] = {"policy" => mock_data}
    data[:client] = Aws::Lambda::Client
    @resp = AWSLambdaPermission.new(function_name: 'test_Lambda', Sid: 'AllowExecutionFromSqs', client_args: { stub_responses: true }, stub_data: [data])
  end

  # def test_policy
  #   assert_equal(@resp.policy,  "")
  # end

  def test_effect
    assert_equal(@resp.effect, 'Allow')
  end

  # def test_principal
  #   assert_equal(@resp.principal, 'test1')
  # end
  #
  # def test_action
  #   assert_equal(@resp.action, 'test1')
  # end
  #
  # def test_resource
  #   assert_equal(@resp.resource, 'test1')
  # end
end