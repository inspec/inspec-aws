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

  def test_lambda_client_non_existing_for_empty_response
    refute AWSLambdaEventSourceMappings.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSLambdaEventSourceMappingsHappyPathTest < Minitest::Test

#   def setup
#     data = {}
#     data[:method] = :list_event_source_mappings
#     mock_data = {}
#     mock_data[:uuid] = 'test1'
#     mock_data[:starting_position] = 'test1'
#     mock_data[:state] = 'test1'
#     data[:data] = { :lambda_client => [mock_data] }
#     data[:client] = Aws::Lambda::Client
#     @lambda_client = AWSLambdaEventSourceMappings.new(client_args: { stub_responses: true }, stub_data: [data])
#   end

#   def test_lambda_client_exists
#     assert @lambda_client.exist?
#   end

#   def test_uuids
#     assert_equal(@lambda_client.uuids, ['test1'])
#   end

#   def test_starting_positions
#     assert_equal(@lambda_client.starting_positions, ['test1'])
#   end

#   def test_states
#     assert_equal(@lambda_client.states, ['test1'])
#   end
end