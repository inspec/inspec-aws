# require 'helper'
# require 'aws_application_autoscaling_scaling_policies'
# require 'aws-sdk-core'

# class AWSApplicationAutoScalingScalingPoliciesConstructorTest < Minitest::Test

#   def test_empty_params_ok
#     AWSApplicationAutoScalingScalingPolicies.new(service_namespace: "test", client_args: { stub_responses: true })
#   end

#   def test_rejects_other_args
#     assert_raises(ArgumentError) { AWSApplicationAutoScalingScalingPolicies.new('rubbish') }
#   end

#   def test_service_namespace_non_existing_for_empty_response
#     refute AWSApplicationAutoScalingScalingPolicies.new(service_namespace: "test", client_args: { stub_responses: true }).exist?
#   end
# end

# class AWSApplicationAutoScalingScalingPoliciesHappyPathTest < Minitest::Test

#   def setup
#     data = {}
#     data[:method] = :describe_scaling_policies
#     mock_data = {}
#     mock_data[:policy_arn] = 'test'
#     mock_data[:policy_name] = 'test'
#     mock_data[:service_namespace] = 'test'
#     mock_data[:resource_id] = 'test'
#     mock_data[:scalable_dimension] = 'test'
#     mock_data[:policy_type] = 'test'
#     mock_data[:creation_time] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
#     data[:data] = { :scaling_policies => [mock_data] }
#     data[:client] = Aws::ApplicationAutoScaling::Client
#     @scaling_policies = AWSApplicationAutoScalingScalingPolicies.new(service_namespace: "test", client_args: { stub_responses: true }, stub_data: [data])
#   end

#   def test_scaling_policies_exists
#     assert @scaling_policies.exists?
#   end

#   def test_policy_arns
#     assert_equal(@scaling_policies.policy_arns, ['test'])
#   end

#   def test_policy_names
#     assert_equal(@scaling_policies.policy_names, ['test'])
#   end

#   def test_service_namespaces
#     assert_equal(@scaling_policies.service_namespaces, ['test'])
#   end

#   def test_resource_ids
#     assert_equal(@scaling_policies.resource_ids, ['test'])
#   end

#   def test_scalable_dimensions
#     assert_equal(@scaling_policies.scalable_dimensions, ['test'])
#   end

#   def test_policy_types
#     assert_equal(@scaling_policies.policy_types, ['test'])
#   end
  
#   def test_creation_times
#     assert_equal(@scaling_policies.creation_times, [Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")])
#   end
# end