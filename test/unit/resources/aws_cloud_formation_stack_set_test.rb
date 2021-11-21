require 'helper'
require 'aws_cloud_formation_stack_set'
require 'aws-sdk-core'

class AWSCloudFormationStackSetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudFormationStackSet.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudFormationStackSet.new(stack_set_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudFormationStackSet.new(unexpected: 9) }
  end
end

class AWSCloudFormationStackSetHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_stack_set
    mock_data = {}
    mock_data[:stack_set_name] = 'test1'
    mock_data[:stack_set_id] = 'test1'
    data[:data] = { stack_set: mock_data }
    data[:client] = Aws::CloudFormation::Client
    @resp = AWSCloudFormationStackSet.new(stack_set_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def stack_set_exists
    assert @resp.exists?
  end

  def test_stack_set_name
    assert_equal(@resp.stack_set_name, 'test1')
  end
end