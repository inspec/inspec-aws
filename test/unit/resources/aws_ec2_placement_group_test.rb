require 'helper'
require 'aws_ec2_placement_group'
require 'aws-sdk-core'

class AWSEC2PlacementGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2PlacementGroup.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2PlacementGroup.new(placement_group_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2PlacementGroup.new(unexpected: 9) }
  end
end

class AWSEC2PlacementGroupSuccessPathTest < Minitest::Test

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
    data[:data] = { placement_groups: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2PlacementGroup.new(placement_group_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_placement_groups_exists
    assert @resp.exists?
  end

  def test_group_name
    assert_equal(@resp.group_name, 'test1')
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end

  def test_strategy
    assert_equal(@resp.strategy, 'test1')
  end

  def test_partition_count
    assert_equal(@resp.partition_count, 1)
  end

  def test_group_id
    assert_equal(@resp.group_id, 'test1')
  end

  def test_tags
    assert_equal(@resp.tags, {})
  end
end
