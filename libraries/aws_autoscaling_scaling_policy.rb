require "aws_backend"

class AWSAutoScalingScalingPolicy < AwsResourceBase
  name "aws_autoscaling_scaling_policy"
  desc "Describes the policies for the specified Auto Scaling group."

  example "
    describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'test') do
      it { should eq 'test' }
    end

    describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'test') do
      it { should exits }
    end
  "
  def initialize(opts = {})
    opts = { auto_scaling_group_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:auto_scaling_group_name])

    raise ArgumentError, "#{@__resource_name__}: auto_scaling_group_name must be provided" unless opts[:auto_scaling_group_name] && !opts[:auto_scaling_group_name].empty?
    @display_name = opts[:auto_scaling_group_name]
    catch_aws_errors do
      resp = @aws.autoscaling_client.describe_policies({ auto_scaling_group_name: opts[:auto_scaling_group_name] })
      @scaling_policies = resp.scaling_policies[0].to_h
      create_resource_methods(@scaling_policies)
    end
  end

  def auto_scaling_group_name
    return nil unless exists?
    @scaling_policies[:auto_scaling_group_name]
  end

  def exists?
    !@scaling_policies.nil? && !@scaling_policies.empty?
  end

  def to_s
    "Auto Scaling Group Name: #{@display_name}"
  end
end
