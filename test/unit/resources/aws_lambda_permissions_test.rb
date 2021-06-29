require 'helper'
require 'aws_lambda_permissions'
require 'aws-sdk-core'

class AWSLambdaPermissionsConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) {AWSLambdaPermissions.new(function_name: "", client_args: { stub_responses: true })}
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSLambdaPermissions.new('rubbish') }
  end
end

class AWSLambdaPermissionsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_policy
    mock_data = "{\"Version\":\"2012-10-17\",\"Id\":\"default\",\"Statement\":[{\"Sid\":\"AllowExecutionFromSqs\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"sqs.amazonaws.com\"},\"Action\":\"lambda:InvokeFunction\",\"Resource\":\"arn:aws:lambda:us-east-2:112758395563:function:test_Lambda\",\"Condition\":{\"ArnLike\":{\"AWS:SourceArn\":\"arn:aws:sqs:us-east-2:112758395563:terraform-example-queue\"}}}]}"
    data[:data] = {"policy" => mock_data}
    data[:client] = Aws::Lambda::Client
    @resp = AWSLambdaPermissions.new(function_name: 'test_Lambda', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_sids
    assert_equal(@resp.sids, ["AllowExecutionFromSqs"])
  end

  def test_effects
    assert_equal(@resp.effects, ['Allow'])
  end

  def test_principals
    assert_equal(@resp.principals, ["sqs.amazonaws.com"])
  end

  def test_actions
    assert_equal(@resp.actions, ["lambda:InvokeFunction"])
  end

  def test_resources
    assert_equal(@resp.resources, ['arn:aws:lambda:us-east-2:112758395563:function:test_Lambda'])
  end
end