require 'helper'
require 'aws_stepfunctions_state_machines'
require 'aws-sdk-core'

class AWSStepFunctionsStateMachinesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSStepFunctionsStateMachines.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSStepFunctionsStateMachines.new('rubbish') }
  end

  def test_work_groups_non_existing_for_empty_response
    refute AWSStepFunctionsStateMachines.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSStepFunctionsStateMachinesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_state_machines
    mock_parameter = {}
    mock_parameter[:state_machine_arn] = 'test1'
    mock_parameter[:name] = 'test1'
    mock_parameter[:type] = 'test1'
    mock_parameter[:creation_date] = Time.parse("2013-06-12T23:52:02Z")
    data[:data] = { :state_machines => [mock_parameter] }
    data[:client] = Aws::States::Client
    @state_machines = AWSStepFunctionsStateMachines.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_state_machines_exists
    assert @state_machines.exist?
  end

  def test_state_machine_arns
    assert_equal(@state_machines.state_machine_arns, ['test1'])
  end

  def test_names
    assert_equal(@state_machines.names, ['test1'])
  end

  def test_types
    assert_equal(@state_machines.types, ['test1'])
  end

  def test_creation_dates
    assert_equal(@state_machines.creation_dates, [Time.parse("2013-06-12T23:52:02Z")])
  end
end