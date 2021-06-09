require 'helper'
require 'aws_application_autoscaling_scalable_target'
require 'aws-sdk-core'

class AWSApplicationAutoScalingScalableTargetConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApplicationAutoScalingScalableTarget.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApplicationAutoScalingScalableTarget.new(service_namespace: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApplicationAutoScalingScalableTarget.new(unexpected: 9) }
  end
end

class AWSApplicationAutoScalingScalableTargetSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_scalable_targets
    mock_data = {}
    mock_data[:service_namespace] = 'test1'
    mock_data[:resource_id] = 'test1'
    mock_data[:scalable_dimension] = 'test1'
    mock_data[:min_capacity] = 1
    mock_data[:max_capacity] = 1
    mock_data[:role_arn] = 'test1'
    mock_data[:creation_time] = Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:suspended_state] = {}
    data[:data] = { scalable_targets: [mock_data] }
    data[:client] = Aws::ApplicationAutoScaling::Client
    @scalable_targets = AWSApplicationAutoScalingScalableTarget.new(service_namespace: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_scalable_targets_group_exists
    assert @scalable_targets.exists?
  end

  def test_service_namespace
    assert_equal(@scalable_targets.service_namespace, 'test1')
  end

  def test_resource_id
    assert_equal(@scalable_targets.resource_id, 'test1')
  end

  def test_scalable_dimension
    assert_equal(@scalable_targets.scalable_dimension, 'test1')
  end

  def test_min_capacity
    assert_equal(@scalable_targets.min_capacity, 1)
  end

  def test_max_capacity
    assert_equal(@scalable_targets.max_capacity, 1)
  end

  def test_role_arn
    assert_equal(@scalable_targets.role_arn, 'test1')
  end

  def test_creation_time
    assert_equal(@scalable_targets.creation_time, Time.parse("2013-08-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_suspended_state
    assert_equal(@scalable_targets.suspended_state, {})
  end
end