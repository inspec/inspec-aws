require 'helper'
require 'aws_stepfunctions_state_machine'
require 'aws-sdk-core'

class AWSStepFunctionsStateMachineConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSStepFunctionsStateMachine.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSStepFunctionsStateMachine.new(state_machine_arn: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSStepFunctionsStateMachine.new(unexpected: 9) }
  end
end

class AWSStepFunctionsStateMachineSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_state_machine
    mock_parameter = {}
    mock_parameter[:state_machine_arn] = 'test1'
    mock_parameter[:name] = 'test1'
    mock_parameter[:definition] = 'test1'
    data[:data] = { states_client: [mock_parameter] }
    data[:client] = Aws::States::Client
    @states_client = AWSStepFunctionsStateMachine.new(state_machine_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_parameter_group_exists
    assert @states_client.exists?
  end

  def test_state_machine_arn
    assert_equal(@states_client.state_machine_arn, 'test1')
  end

  def test_name
    assert_equal(@states_client.name, 'test1')
  end

  def test_status
    assert_equal(@states_client.status, 'test1')
  end
end