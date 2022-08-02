require 'helper'
require 'aws_lambda_event_invoke_config'
require 'aws-sdk-core'

class AWSLambdaEventInvokeConfigConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSLambdaEventInvokeConfig.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSLambdaEventInvokeConfig.new(function_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSLambdaEventInvokeConfig.new(unexpected: 9) }
  end
end

class AWSLambdaEventInvokeConfigSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_function_event_invoke_config
    mock_data = {}
    mock_data[:function_arn] = 'test1'
    mock_data[:last_modified] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:maximum_retry_attempts] = 1
    mock_data[:maximum_event_age_in_seconds] = 1
    mock_data[:destination_config] = {}
    data[:data] = mock_data
    data[:client] = Aws::Lambda::Client
    @res = AWSLambdaEventInvokeConfig.new(function_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_function_arn
    assert_equal(@res.function_arn, 'test1')
  end

  def test_last_modified
    assert_equal(@res.last_modified, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_maximum_retry_attempts
    assert_equal(@res.maximum_retry_attempts, 1 )
  end

  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, 'test1')
  end
end