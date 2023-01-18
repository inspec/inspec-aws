require 'helper'
require 'aws_autoscaling_scaling_policies'
require 'aws-sdk-core'

class AWSAutoScalingScalingPoliciesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSAutoScalingScalingPolicies.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSAutoScalingScalingPolicies.new('rubbish') }
  end

  def test_autoscaling_scaling_policies_non_existing_for_empty_response
    refute AWSAutoScalingScalingPolicies.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSAutoScalingScalingPoliciesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_policies
    mock_data = {}
    mock_data[:auto_scaling_group_name] = 'test1'
    mock_data[:policy_name] = 'test1'
    mock_data[:policy_arn] = 'test1'
    mock_data[:adjustment_type] = 'test1'
    mock_data[:min_adjustment_step] = 1
    mock_data[:min_adjustment_magnitude] = 1
    mock_data[:scaling_adjustment] = 1
    mock_data[:metric_aggregation_type] = 'test1'
    mock_data[:estimated_instance_warmup] = 1
    data[:data] = { :scaling_policies => [mock_data] }
    data[:client] = Aws::AutoScaling::Client
    @scaling_policies = AWSAutoScalingScalingPolicies.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_work_groups_exists
    assert @scaling_policies.exist?
  end

  def test_auto_scaling_group_names
    assert_equal(@scaling_policies.auto_scaling_group_names, ['test1'])
  end

  def test_policy_names
    assert_equal(@scaling_policies.policy_names, ['test1'])
  end

  def test_policy_arns
    assert_equal(@scaling_policies.policy_arns, ['test1'])
  end

  def test_adjustment_types
    assert_equal(@scaling_policies.adjustment_types, ['test1'])
  end

  def test_min_adjustment_steps
    assert_equal(@scaling_policies.min_adjustment_steps, [1])
  end

  def test_min_adjustment_magnitudes
    assert_equal(@scaling_policies.min_adjustment_magnitudes, [1])
  end

  def test_scaling_adjustments
    assert_equal(@scaling_policies.scaling_adjustments, [1])
  end

  def test_metric_aggregation_types
    assert_equal(@scaling_policies.metric_aggregation_types, ['test1'])
  end

  def test_estimated_instance_warmups
    assert_equal(@scaling_policies.estimated_instance_warmups, [1])
  end
end