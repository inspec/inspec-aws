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
    mock_data[:uuid] = 'test'
    mock_data[:starting_position] = 'test'
    # mock_data[:starting_position_timestamp] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] = { :event_source_mappings => [mock_data] }
    data[:client] = Aws::Lambda::Client
    @resp = AWSLambdaEventSourceMappings.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_event_source_mappings_exists
    assert @resp.exist?
  end

  def test_uuids
    assert_equal(@resp.uuids, ['test'])
  end

  def test_starting_positions
    assert_equal(@resp.starting_positions, ['test'])
  end

  # def test_starting_position_timestamps
  #   assert_equal(@resp.starting_position_timestamps, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  # end
end