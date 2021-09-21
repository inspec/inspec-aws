require 'helper'
require 'aws_ec2_placement_groups'
require 'aws-sdk-core'

class AWSEC2PlacementGroupsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2PlacementGroups.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2PlacementGroups.new('rubbish') }
  end

  def test_placement_group_non_existing_for_empty_response
    refute AWSEC2PlacementGroups.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2PlacementGroupsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_placement_groups
    mock_data = {}
    mock_data[:group_name] = 'test1'
    mock_data[:state] = 'test1'
    mock_data[:strategy] = 'test1'
    mock_data[:partition_count] = 1
    mock_data[:group_id] = 'test1'
    mock_data[:tags] = []
    data[:data] = { :placement_groups => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2PlacementGroups.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_group_names
    assert_equal(@resp.group_names, ['test1'])
  end

  def test_states
    assert_equal(@resp.states, ['test1'])
  end

  def test_strategies
    assert_equal(@resp.strategies, ['test1'])
  end

  def test_partition_counts
    assert_equal(@resp.partition_counts, [1])
  end

  def test_group_ids
    assert_equal(@resp.group_ids, ['test1'])
  end

  def test_tags
    assert_equal(@resp.tags, [[]])
  end
end
