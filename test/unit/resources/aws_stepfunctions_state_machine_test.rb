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
    mock_data = {}
    mock_data[:state_machine_arn] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:definition] = 'test1'
    mock_data[:role_arn] = 'test1'
    mock_data[:type] = 'test1'
    mock_data[:logging_configuration] = {}
    mock_data[:creation_date] = Time.parse("2013-06-12T23:52:02Z")
    data[:data] = [mock_data]
    data[:client] = Aws::States::Client
    @state_machine = AWSStepFunctionsStateMachine.new(state_machine_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_state_machine_exists
    assert @state_machine.exists?
  end

  def test_state_machine_arn
    assert_equal(@state_machine.state_machine_arn, 'test1')
  end

  def test_name
    assert_equal(@state_machine.name, 'test1')
  end

  def test_status
    assert_equal(@state_machine.status, 'test1')
  end

  def test_definition
    assert_equal(@state_machine.definition, 'test1')
  end

  def test_role_arn
    assert_equal(@state_machine.role_arn, 'test1')
  end

  def test_logging_configuration
    assert_equal(@state_machine.logging_configuration, {})
  end

  def test_creation_date
    assert_equal(@state_machine.creation_date, Time.parse("2013-06-12T23:52:02Z"))
  end

  def test_resource_id
    refute_nil(@state_machine.resource_id)
    assert_equal(@state_machine.resource_id, 'test1')
  end
end