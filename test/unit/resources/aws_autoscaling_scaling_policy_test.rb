require 'helper'
require 'aws_autoscaling_scaling_policy'
require 'aws-sdk-core'

class AWSAutoScalingScalingPolicyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSAutoScalingScalingPolicy.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSAutoScalingScalingPolicy.new(auto_scaling_group_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSAutoScalingScalingPolicy.new(unexpected: 9) }
  end
end

class AWSAutoScalingScalingPolicySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_policies
    mock_parameter = {}
    mock_parameter[:auto_scaling_group_name] = 'test1'
    mock_parameter[:policy_name] = 'test1'
    mock_parameter[:policy_arn] = 'test1'
    mock_parameter[:policy_type] = 'test1'
    mock_parameter[:adjustment_type] = 'test1'
    mock_parameter[:min_adjustment_step] = 1
    mock_parameter[:min_adjustment_magnitude] = 1
    mock_parameter[:scaling_adjustment] = 1
    mock_parameter[:metric_aggregation_type] = 'test1'
    mock_parameter[:estimated_instance_warmup] = 1
    data[:data] = { scaling_policies: [mock_parameter] }
    data[:client] = Aws::AutoScaling::Client
    @scaling_policies = AWSAutoScalingScalingPolicy.new(auto_scaling_group_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_scaling_policy_exists
    assert @scaling_policies.exists?
  end

  def test_auto_scaling_group_name
    assert_equal(@scaling_policies.auto_scaling_group_name, 'test1')
  end

  def test_policy_name
    assert_equal(@scaling_policies.policy_name, 'test1')
  end

  def test_policy_arn
    assert_equal(@scaling_policies.policy_arn, 'test1')
  end

  def test_policy_type
    assert_equal(@scaling_policies.policy_type, 'test1')
  end

  def test_adjustment_type
    assert_equal(@scaling_policies.adjustment_type, 'test1')
  end

  def test_min_adjustment_step
    assert_equal(@scaling_policies.min_adjustment_step, 1)
  end

  def test_min_adjustment_magnitude
    assert_equal(@scaling_policies.min_adjustment_magnitude, 1)
  end

  def test_scaling_adjustment
    assert_equal(@scaling_policies.scaling_adjustment, 1)
  end

  def test_metric_aggregation_type
    assert_equal(@scaling_policies.metric_aggregation_type, 'test1')
  end

  def test_estimated_instance_warmup
    assert_equal(@scaling_policies.estimated_instance_warmup, 1)
  end
end