require 'helper'
require 'aws_lambda_event_invoke_configs'
require 'aws-sdk-core'

class AWSLambdaEventInvokeConfigsConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSLambdaEventInvokeConfigs.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSLambdaEventInvokeConfigs.new(function_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSLambdaEventInvokeConfigs.new(unexpected: 9) }
  end
end

class AWSLambdaEventInvokeConfigsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_function_event_invoke_configs
    mock_data = {}
    mock_data[:last_modified] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:function_arn] = 'test1'
    mock_data[:maximum_retry_attempts] = 1
    mock_data[:maximum_event_age_in_seconds] = 1
    mock_data[:destination_config] = {}
    data[:data] = { :function_event_invoke_configs => [mock_data] }
    data[:client] = Aws::Lambda::Client
    @resp = AWSLambdaEventInvokeConfigs.new(function_name: "test1", client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_last_modified
    assert_equal(@resp.last_modified, [Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_function_arns
    assert_equal(@resp.function_arns, ['test1'])
  end

  def test_maximum_retry_attempts
    assert_equal(@resp.maximum_retry_attempts, [1])
  end
end