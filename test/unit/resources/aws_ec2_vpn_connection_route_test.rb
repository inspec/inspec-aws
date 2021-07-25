require 'helper'
require 'aws_lambda_function'
require 'aws-sdk-core'

class AWSLambdaFunctionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSLambdaFunction.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSLambdaFunction.new(function_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSLambdaFunction.new(unexpected: 9) }
  end
end

class AWSLambdaFunctionSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_function
    mock_data = {}
    mock_data[:function_name] = 'test1'
    mock_data[:function_arn] = 'test1'
    mock_data[:runtime] = 'test1'
    mock_data[:handler] = 'test1'
    mock_data[:code_size] = 1
    mock_data[:description] = 'test1'
    mock_data[:timeout] = 1
    mock_data[:memory_size] = 1
    mock_data[:last_modified] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:code_sha_256] = 'test1'
    mock_data[:version] = 'test1'
    mock_data[:vpc_config] = {}
    mock_data[:dead_letter_config] = {}
    mock_data[:environment] = {}
    mock_data[:kms_key_arn] = 'test1'
    mock_data[:tracing_config] = {}
    mock_data[:master_arn] = 'test1'
    mock_data[:revision_id] = 'test1'
    mock_data[:state] = 'test1'
    mock_data[:state_reason] = 'test1'
    mock_data[:state_reason_code] = 'test1'
    mock_data[:last_update_status] = 'test1'
    mock_data[:last_update_status_reason] = 'test1'
    mock_data[:last_update_status_reason_code] = 'test1'
    data[:data] = { configuration: mock_data }
    data[:client] = Aws::Lambda::Client
    @configuration = AWSLambdaFunction.new(function_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_function_exists
    assert @configuration.exists?
  end

  def test_function_name
    assert_equal(@configuration.function_name, 'test1')
  end

  def test_function_arn
    assert_equal(@configuration.function_arn, 'test1')
  end

  def test_runtime
    assert_equal(@configuration.runtime, 'test1')
  end

  def test_handler
    assert_equal(@configuration.handler, 'test1')
  end

  def test_code_size
    assert_equal(@configuration.code_size, 1)
  end

  def test_description
    assert_equal(@configuration.description, 'test1')
  end

  def test_timeout
    assert_equal(@configuration.timeout, 1)
  end

  def test_memory_size
    assert_equal(@configuration.memory_size, 1)
  end

  def test_last_modified
    assert_equal(@configuration.last_modified, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_code_sha_256
    assert_equal(@configuration.code_sha_256, 'test1')
  end

  def test_version
    assert_equal(@configuration.version, 'test1')
  end

  def test_vpc_config
    assert_equal(@configuration.vpc_config, {})
  end

  def test_dead_letter_config
    assert_equal(@configuration.dead_letter_config, {})
  end

  def test_environment
    assert_equal(@configuration.environment, {})
  end

  def test_kms_key_arn
    assert_equal(@configuration.kms_key_arn, 'test1')
  end

  def test_tracing_config
    assert_equal(@configuration.tracing_config, {})
  end

  def test_master_arn
    assert_equal(@configuration.master_arn, 'test1')
  end

  def test_revision_id
    assert_equal(@configuration.revision_id, 'test1')
  end

  def test_state
    assert_equal(@configuration.state, 'test1')
  end

  def test_state_reason
    assert_equal(@configuration.state_reason, 'test1')
  end

  def test_state_reason_code
    assert_equal(@configuration.state_reason_code, 'test1')
  end

  def test_last_update_status
    assert_equal(@configuration.last_update_status, 'test1')
  end

  def test_last_update_status_reason
    assert_equal(@configuration.last_update_status_reason, 'test1')
  end

  def test_last_update_status_reason_code
    assert_equal(@configuration.last_update_status_reason_code, 'test1')
  end
end