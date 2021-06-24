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
    mock_parameter = {}
    mock_parameter[:uuid] = 'test1'
    mock_parameter[:starting_position] = 'test1'
    # mock_parameter[:starting_position_timestamp] = 'test1'
    data[:data] = mock_parameter
    data[:client] = Aws::Lambda::Client
    @res = AWSLambdaEventSourceMapping.new(uuid: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_eventsourcemapping_exists
    assert @res.exists?
  end

  def test_uuid
    assert_equal(@res.uuid, 'test1')
  end

  def test_starting_position
    assert_equal(@res.starting_position, 'test1')
  end
end