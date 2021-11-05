require 'helper'
require 'aws_ec2_placement_group'
require 'aws-sdk-core'

class AWSEC2PlacementGroupConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2PlacementGroup.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_group_id_as_hash_eight_sign
    AWSEC2PlacementGroup.new(group_id: 'pg-006f2fd0a03d51323', client_args: { stub_responses: true })
  end

  def test_accepts_group_id_as_hash
    AWSEC2PlacementGroup.new(group_id: 'pg-006f2fd0a03d51323', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2PlacementGroup.new(rubbish: 9) }
  end
end

class AWSEC2PlacementGroupPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_placement_groups
    mock_data = {}
    mock_data[:group_id] = 'test'
    mock_data[:group_name] = 'test'
    mock_data[:strategy] = 'test'
    mock_data[:partition_count] = 1
    data[:data] = { :placement_groups => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2PlacementGroup.new(group_id: 'pg-006f2fd0a03d51323', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_placement_groups_exists
    assert @resp.exists?
  end
  
  def test_group_id
    assert_equal(@resp.group_id, 'test')
  end

  def test_group_name
    assert_equal(@resp.group_name, 'test')
  end

  def test_strategy
    assert_equal(@resp.strategy, 'test')
  end

  def test_partition_count
    assert_equal(@resp.partition_count, 1)
  end
end