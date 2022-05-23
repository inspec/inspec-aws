require 'helper'
require 'aws_stepfunctions_activity'
require 'aws-sdk-core'

class AWSStepFunctionsActivityConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSStepFunctionsActivity.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSStepFunctionsActivity.new(activity_arn: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSStepFunctionsActivity.new(unexpected: 9) }
  end
end

class AWSStepFunctionsActivitySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_activity
    mock_data = {}
    mock_data[:activity_arn] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:creation_date] = Time.parse('2021-09-20 13:10:26.000000000 +0000')
    data[:data] = mock_data
    data[:client] = Aws::States::Client
    @resp = AWSStepFunctionsActivity.new(activity_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_activity
    assert @resp.exists?
  end

  def test_activity_arn
    assert_equal(@resp.activity_arn, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_creation_date
    assert_equal(@resp.creation_date, Time.parse('2021-09-20 13:10:26.000000000 +0000'))
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end
