require 'helper'
require 'aws_application_autoscaling_scaling_policy'
require 'aws-sdk-core'

class AWSApplicationAutoScalingScalingPolicyConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) {AWSApplicationAutoScalingScalingPolicy.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_service_namespace_as_hash_eight_sign
    AWSApplicationAutoScalingScalingPolicy.new(service_namespace: 'test', client_args: { stub_responses: true })
  end

  def test_accepts_service_namespace_as_hash
    AWSApplicationAutoScalingScalingPolicy.new(service_namespace: 'test', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) {AWSApplicationAutoScalingScalingPolicy.new(rubbish: 9) }
  end
end

class AWSApplicationAutoScalingScalingPolicyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_scaling_policies
    mock_data = {}
    mock_data[:policy_arn] = 'test'
    mock_data[:policy_name] = 'test'
    mock_data[:service_namespace] = 'test'
    mock_data[:resource_id] = 'test'
    mock_data[:scalable_dimension] = 'test'
    mock_data[:policy_type] = 'test'
    mock_data[:creation_time] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] = { :scaling_policies => [mock_data] }
    data[:client] = Aws::ApplicationAutoScaling::Client
    @scaling_policies =AWSApplicationAutoScalingScalingPolicy.new(service_namespace: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_scaling_policies_exists
    assert @scaling_policies.exists?
  end

  def test_scaling_policies_available
    assert @scaling_policies.available?
  end

  def test_policy_arn
    assert_equal(@scaling_policies.policy_arn, 'test')
  end

  def test_policy_name
    assert_equal(@scaling_policies.policy_name, 'test')
  end

  def test_service_namespace
    assert_equal(@scaling_policies.service_namespace, 'test')
  end

  def test_resource_id
    assert_equal(@scaling_policies.resource_id, 'test')
  end

  def test_scalable_dimension
    assert_equal(@scaling_policies.scalable_dimension, 'test')
  end

  def test_policy_type
    assert_equal(@scaling_policies.policy_type, 'test')
  end
  
  def test_creation_time
    assert_equal(@scaling_policies.creation_time, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end
end