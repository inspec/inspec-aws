require 'helper'
require 'aws_application_autoscaling_scalable_targets'
require 'aws-sdk-core'

class AWSApplicationAutoScalingScalableTargetsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApplicationAutoScalingScalableTargets.new(service_namespace: "test", client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApplicationAutoScalingScalableTargets.new('rubbish') }
  end

  def test_scalable_targets_non_existing_for_empty_response
    refute AWSApplicationAutoScalingScalableTargets.new(service_namespace: "test", client_args: { stub_responses: true }).exist?
  end
end

class AWSApplicationAutoScalingScalableTargetsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_scalable_targets
    mock_data = {}
    mock_data[:service_namespace] = 'test'
    mock_data[:resource_id] = 'test'
    mock_data[:scalable_dimension] = 'test'
    mock_data[:min_capacity] = 1
    mock_data[:max_capacity] = 1
    mock_data[:role_arn] = 'test'
    mock_data[:creation_time] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] = { :scalable_targets => [mock_data] }
    data[:client] = Aws::ApplicationAutoScaling::Client
    @scalable_targets = AWSApplicationAutoScalingScalableTargets.new(service_namespace: "test", client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_scalable_targets_exists
    assert @scalable_targets.exist?
  end

  def test_service_namespaces
    assert_equal(@scalable_targets.service_namespaces, ['test'])
  end

  def test_resource_ids
    assert_equal(@scalable_targets.resource_ids, ['test'])
  end

  def test_scalable_dimensions
    assert_equal(@scalable_targets.scalable_dimensions, ['test'])
  end

  def test_min_capacities
    assert_equal(@scalable_targets.min_capacities, [1])
  end

  def test_max_capacities
    assert_equal(@scalable_targets.max_capacities, [1])
  end

  def test_role_arns
    assert_equal(@scalable_targets.role_arns, ['test'])
  end

  def test_creation_times
    assert_equal(@scalable_targets.creation_times, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
  end
end










