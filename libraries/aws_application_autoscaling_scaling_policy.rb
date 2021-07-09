# frozen_string_literal: true

require 'aws_backend'

class AWSApplicationAutoScalingScalingPolicy < AwsResourceBase
  name 'aws_application_autoscaling_scaling_policy'
  desc 'Describes the Application AutoScaling scaling policies for the specified service namespace.'

  example "
    describe aws_application_autoscaling_scaling_policy(service_namespace: 'ec2') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { service_namespace: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:service_namespace])

    raise ArgumentError, "#{@__resource_name__}: service_namespace must be provided" unless opts[:service_namespace] && !opts[:service_namespace].empty?
    @display_name = opts[:service_namespace]
    catch_aws_errors do
      resp = @aws.applicationautoscaling_client.describe_scaling_policies({ service_namespace: opts[:service_namespace] })
      @scaling_policies = resp.scaling_policies[0].to_h
      create_resource_methods(@scaling_policies)
    end
  end

  def id
    return nil unless exists?
    @scaling_policies[:service_namespace]
  end

  def exists?
    !@scaling_policies.nil? && !@scaling_policies.empty?
  end

  def to_s
    "Service Namespace: #{@display_name}"
  end
end
