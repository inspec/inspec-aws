require 'helper'
require 'aws_lambda_event_source_mapping'
require 'aws-sdk-core'

class AWSLambdaEventSourceMappingConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSLambdaEventSourceMapping.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSLambdaEventSourceMapping.new(uuid: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSLambdaEventSourceMapping.new(unexpected: 9) }
  end
end

class AWSLambdaEventSourceMappingSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_event_source_mapping
    mock_data = {}
    mock_data[:uuid] = 'test1'
    mock_data[:starting_position_timestamp] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:starting_position] = 'test1'
    mock_data[:batch_size] = 1
    mock_data[:maximum_batching_window_in_seconds] = 1
    mock_data[:parallelization_factor] = 1
    mock_data[:event_source_arn] = 'test1'
    mock_data[:function_arn] = 'test1'
    mock_data[:last_modified] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:last_processing_result] = 'test1'
    mock_data[:state] = 'test1'
    mock_data[:state_transition_reason] = 'test1'
    mock_data[:destination_config] = {}
    mock_data[:topics] = ['test1']
    mock_data[:queues] = ['test1']
    mock_data[:maximum_record_age_in_seconds] = 1
    mock_data[:bisect_batch_on_function_error] = true
    mock_data[:maximum_retry_attempts] = 1
    data[:data] = mock_data
    data[:client] = Aws::Lambda::Client
    @resp = AWSLambdaEventSourceMapping.new(uuid: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_eventsourcemapping_exists
    assert @resp.exists?
  end

  def test_uuid
    assert_equal(@resp.uuid, 'test1')
  end

  def test_starting_position_timestamp
    assert_equal(@resp.starting_position_timestamp, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_starting_position
    assert_equal(@resp.starting_position, 'test1')
  end

  def test_batch_size
    assert_equal(@resp.batch_size, 1 )
  end

  def test_maximum_batching_window_in_seconds
    assert_equal(@resp.maximum_batching_window_in_seconds, 1 )
  end

  def test_starting_position
    assert_equal(@resp.starting_position, 'test1')
  end

  def test_parallelization_factor
    assert_equal(@resp.parallelization_factor, 1 )
  end

  def test_event_source_arn
    assert_equal(@resp.event_source_arn, 'test1')
  end

  def test_function_arn
    assert_equal(@resp.function_arn, 'test1')
  end

  def test_last_modified
    assert_equal(@resp.last_modified, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_last_processing_result
    assert_equal(@resp.last_processing_result, 'test1')
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end

  def test_destination_config
    assert_equal(@resp.destination_config, {})
  end

  def test_state_transition_reason
    assert_equal(@resp.state_transition_reason, 'test1')
  end

  def test_topics
    assert_equal(@resp.topics, ['test1'])
  end

  def test_queues
    assert_equal(@resp.queues, ['test1'])
  end

  def test_maximum_record_age_in_seconds
    assert_equal(@resp.maximum_record_age_in_seconds, 1 )
  end

  def test_bisect_batch_on_function_error
    assert_equal(@resp.bisect_batch_on_function_error, true)
  end

  def test_maximum_retry_attempts
    assert_equal(@resp.maximum_retry_attempts, 1 )
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end