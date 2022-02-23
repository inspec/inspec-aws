require 'helper'
require 'aws_stepfunctions_activities'
require 'aws-sdk-core'

class AWSStepFunctionsActivitiesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSStepFunctionsActivities.new(client_args: { stub_responses: true })
  end

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSStepFunctionsActivities.new(unexpected: 9, client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSStepFunctionsActivities.new(unexpected: 9) }
  end
end

class AWSStepFunctionsActivitiesSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_activities
    mock_data = {}
    mock_data[:activity_arn] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:creation_date] = Time.parse('2021-09-20 13:10:26.000000000 +0000')
    data[:data] = { activities: [mock_data] }
    data[:client] = Aws::States::Client
    @resp = AWSStepFunctionsActivities.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_activities_exist
    assert @resp.exists?
  end

  def test_activity_arns
    assert_equal(@resp.activity_arns, ['test1'])
  end

  def test_names
    assert_equal(@resp.names, ['test1'])
  end

  def test_creation_dates
    assert_equal(@resp.creation_dates, [Time.parse('2021-09-20 13:10:26.000000000 +0000')])
  end
end