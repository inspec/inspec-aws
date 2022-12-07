require 'aws_backend'

class AWSAutoScalingScalingPolicies < AwsResourceBase
  name 'aws_autoscaling_scaling_policies'
  desc 'Describes the policies for the specified Auto Scaling group.'
  example "
    describe aws_autoscaling_scaling_policies do
      it { should exist }
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:auto_scaling_group_names,        field: :auto_scaling_group_name)
             .register_column(:policy_names,                    field: :policy_name)
             .register_column(:policy_arns,                     field: :policy_arn)
             .register_column(:policy_types,                    field: :policy_type)
             .register_column(:adjustment_types,                field: :adjustment_type)
             .register_column(:min_adjustment_steps,            field: :min_adjustment_step)
             .register_column(:min_adjustment_magnitudes,       field: :min_adjustment_magnitude)
             .register_column(:scaling_adjustments,             field: :scaling_adjustment)
             .register_column(:cooldowns,                       field: :cooldown)
             .register_column(:step_adjustments,                field: :step_adjustments)
             .register_column(:metric_aggregation_types,        field: :metric_aggregation_type)
             .register_column(:estimated_instance_warmups,      field: :estimated_instance_warmup)
             .register_column(:target_tracking_configurations,  field: :target_tracking_configuration)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @scaling_policies = @aws.autoscaling_client.describe_policies
    end
    return [] if !@scaling_policies || @scaling_policies.empty?
    @table = @scaling_policies.scaling_policies.map(&:to_h)
  end
end
