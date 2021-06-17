require 'helper'
require 'aws_lambda_functions'
require 'aws-sdk-core'

class AWSLambdaFunctionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSLambdaFunctions.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSLambdaFunctions.new('rubbish') }
  end

  def test_functions_non_existing_for_empty_response
    refute AWSLambdaFunctions.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSLambdaFunctionsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_functions
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
    data[:data] = { :functions => [mock_data] }
    data[:client] = Aws::Lambda::Client
    @functions = AWSLambdaFunctions.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_functions_exists
    assert @functions.exist?
  end

  def test_function_names
    assert_equal(@functions.function_names, ['test1'])
  end

  def test_function_arns
    assert_equal(@functions.function_arns, ['test1'])
  end

  def test_runtimes
    assert_equal(@functions.runtimes, ['test1'])
  end

  def test_handlers
    assert_equal(@functions.handlers, ['test1'])
  end

  def test_code_sizes
    assert_equal(@functions.code_sizes, [1])
  end

  def test_descriptions
    assert_equal(@functions.descriptions, ['test1'])
  end

  def test_timeouts
    assert_equal(@functions.timeouts, [1])
  end

  def test_memory_sizes
    assert_equal(@functions.memory_sizes, [1])
  end

  def test_last_modified
    assert_equal(@functions.last_modified, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_code_sha_256
    assert_equal(@functions.code_sha_256, ['test1'])
  end

  def test_versions
    assert_equal(@functions.versions, ['test1'])
  end

  def test_kms_key_arns
    assert_equal(@functions.kms_key_arns, ['test1'])
  end

  def test_master_arns
    assert_equal(@functions.master_arns, ['test1'])
  end

  def test_revision_ids
    assert_equal(@functions.revision_ids, ['test1'])
  end

  def test_states
    assert_equal(@functions.states, ['test1'])
  end

  def test_state_reasons
    assert_equal(@functions.state_reasons, ['test1'])
  end

  def test_state_reason_codes
    assert_equal(@functions.state_reason_codes, ['test1'])
  end

  def test_last_update_statuses
    assert_equal(@functions.last_update_statuses, ['test1'])
  end

  def test_last_update_status_reasons
    assert_equal(@functions.last_update_status_reasons, ['test1'])
  end

  def test_last_update_status_reason_codes
    assert_equal(@functions.last_update_status_reason_codes, ['test1'])
  end
end