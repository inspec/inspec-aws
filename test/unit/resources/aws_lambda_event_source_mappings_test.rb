require 'helper'
require 'aws_lambda_event_source_mappings'
require 'aws-sdk-core'

class AWSLambdaEventSourceMappingsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSLambdaEventSourceMappings.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSLambdaEventSourceMappings.new('rubbish') }
  end

  def test_event_source_mappings_non_existing_for_empty_response
    refute AWSLambdaEventSourceMappings.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSLambdaEventSourceMappingsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_event_source_mappings
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
    mock_data[:topics] = ['test1']
    mock_data[:queues] = ['test1']
    mock_data[:maximum_record_age_in_seconds] = 1
    mock_data[:bisect_batch_on_function_error] = true
    mock_data[:maximum_retry_attempts] = 1
    data[:data] = { :event_source_mappings => [mock_data] }
    data[:client] = Aws::Lambda::Client
    @res = AWSLambdaEventSourceMappings.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_event_source_mappings_exists
    assert @res.exist?
  end

  def test_uuids
    assert_equal(@res.uuids, ['test1'])
  end

  def test_starting_positions
    assert_equal(@res.starting_positions, ['test1'])
  end

  def test_starting_position_timestamps
    assert_equal(@res.starting_position_timestamps, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_batch_sizes
    assert_equal(@res.batch_sizes, [1] )
  end

  def test_maximum_batching_window_in_seconds
    assert_equal(@res.maximum_batching_window_in_seconds, [1] )
  end

  def test_starting_positions
    assert_equal(@res.starting_positions, ['test1'])
  end

  def test_parallelization_factors
    assert_equal(@res.parallelization_factors, [1] )
  end

  def test_event_source_arns
    assert_equal(@res.event_source_arns, ['test1'])
  end

  def test_function_arns
    assert_equal(@res.function_arns, ['test1'])
  end

  def test_last_modified
    assert_equal(@res.last_modified, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end

  def test_last_processing_results
    assert_equal(@res.last_processing_results, ['test1'])
  end

  def test_states
    assert_equal(@res.states, ['test1'])
  end

  def test_state_transition_reasons
    assert_equal(@res.state_transition_reasons, ['test1'])
  end

  def test_topics
    assert_equal(@res.topics, [['test1']])
  end

  def test_queues
    assert_equal(@res.queues, [['test1']])
  end

  def test_maximum_record_age_in_seconds
    assert_equal(@res.maximum_record_age_in_seconds, [1] )
  end

  def test_bisect_batch_on_function_errors
    assert_equal(@res.bisect_batch_on_function_errors, [true])
  end

  def test_maximum_retry_attempts
    assert_equal(@res.maximum_retry_attempts, [1] )
  end

end