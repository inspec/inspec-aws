require 'helper'
require 'aws_application_autoscaling_scaling_policy'
require 'aws-sdk-core'

class AWSApplicationAutoScalingScalingPolicyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApplicationAutoScalingScalingPolicy.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApplicationAutoScalingScalingPolicy.new(service_namespace: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApplicationAutoScalingScalingPolicy.new(unexpected: 9) }
  end
end

class AWSApplicationAutoScalingScalingPolicySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_scaling_policies
    mock_parameter = {}
    mock_parameter[:policy_arn] = 'test1'
    mock_parameter[:policy_name] = 'test1'
    mock_parameter[:service_namespace] = 'test1'
    mock_parameter[:resource_id] = 'test1'
    mock_parameter[:scalable_dimension] = 'test1'
    mock_parameter[:policy_type] = 'test1'
    mock_parameter[:step_scaling_policy_configuration] = {}
    mock_parameter[:alarms] = []
    mock_parameter[:creation_time] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] = { scaling_policies: [mock_parameter] }
    data[:client] = Aws::ApplicationAutoScaling::Client
    @scaling_policies = AWSApplicationAutoScalingScalingPolicy.new(service_namespace: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_scaling_policies_group_exists
    assert @scaling_policies.exists?
  end

  def test_policy_arn
    assert_equal(@scaling_policies.policy_arn, 'test1')
  end

  def test_policy_name
    assert_equal(@scaling_policies.policy_name, 'test1')
  end

  def test_service_namespace
    assert_equal(@scaling_policies.service_namespace, 'test1')
  end

  def test_resource_id
    assert_equal(@scaling_policies.resource_id, 'test1')
  end

  def test_scalable_dimension
    assert_equal(@scaling_policies.scalable_dimension, 'test1')
  end

  def test_policy_type
    assert_equal(@scaling_policies.policy_type, 'test1')
  end

  def test_step_scaling_policy_configuration
    assert_equal(@scaling_policies.step_scaling_policy_configuration, {})
  end

  def test_alarms
    assert_equal(@scaling_policies.alarms, [])
  end

  def test_creation_time
    assert_equal(@scaling_policies.creation_time, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end
end