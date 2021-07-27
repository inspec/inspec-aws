require 'helper'
require 'aws_elasticloadbalancingv2_target_groups'
require 'aws-sdk-core'

class AWSElasticLoadBalancingV2TargetGroupsConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2TargetGroups.new(target_group_arns: 'test1', client_args: { stub_responses: true }) }
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSElasticLoadBalancingV2TargetGroups.new('rubbish') }
  end

  def test_work_groups_non_existing_for_empty_response
    refute AWSElasticLoadBalancingV2TargetGroups.new( client_args: { stub_responses: true }).exist?
  end
end

class AWSElasticLoadBalancingV2TargetGroupsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_target_groups
    mock_data = {}
    mock_data[:target_group_arn] = 'test1'
    mock_data[:target_group_name] = 'test1'
    mock_data[:protocol] = 'test1'
    data[:data] = { :target_groups => [mock_data] }
    data[:client] = Aws::ElasticLoadBalancingV2::Client
    @target_groups = AWSElasticLoadBalancingV2TargetGroups.new( client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_target_groups_exists
    assert @target_groups.exist?
  end

  def test_target_group_arns
    assert_equal(@target_groups.target_group_arns, ['test1'])
  end

  def test_target_group_names
    assert_equal(@target_groups.target_group_names, ['test1'])
  end

  def test_protocols
    assert_equal(@target_groups.protocols, ['test1'])
  end
end