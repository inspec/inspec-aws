require 'helper'
require 'aws_cloud_formation_stack_sets'
require 'aws-sdk-core'

class AWSCloudFormationStackSetsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCloudFormationStackSets.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCloudFormationStackSets.new('rubbish') }
  end

  def test_job_definitions_non_existing_for_empty_response
    refute AWSCloudFormationStackSets.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSCloudFormationStackSetsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_stack_set
    mock_parameter = {}
    mock_parameter[:stack_set_name] = 'test1'
    mock_parameter[:stack_set_id] = 'test1'
    mock_parameter[:etag] = 'test1'
    data[:data] = { summaries: [mock_parameter] }
    data[:client] = Aws::CloudFormation::Client
    @stack_set = AWSCloudFormationStackSets.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def stack_set_exists
    assert @stack_set.exists?
  end

  def test_stack_set_id
    assert_equal(@stack_set.stack_set_names, test1)
  end

  def test_stack_set_etag
    assert_equal(@stack_set.stack_set_ids test1)
  end
end