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

  def test_stack_set_non_existing_for_empty_response
    refute AWSCloudFormationStackSets.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSCloudFormationStackSetsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_stack_sets
    mock_data = {}
    mock_data[:stack_set_name] = 'test1'
    mock_data[:stack_set_id] = 'test1'
    data[:data] = { :summaries => [mock_data] }
    data[:client] = Aws::CloudFormation::Client
    @resp = AWSCloudFormationStackSets.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def stack_set_exists
    assert @resp.exists?
  end

  def test_stack_set_names
    assert_equal(@resp.stack_set_names, ['test1'])
  end

  def test_stack_set_ids
    assert_equal(@resp.stack_set_ids, ['test1'])
  end
end