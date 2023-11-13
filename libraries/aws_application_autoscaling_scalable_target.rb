require "aws_backend"

class AWSApplicationAutoScalingScalableTarget < AwsResourceBase
  name "aws_application_autoscaling_scalable_target"
  desc "Gets information about the scalable targets in the specified namespace."
  example <<-EXAMPLE
    describe aws_application_autoscaling_scalable_target(service_namespace: 'ec2') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { service_namespace: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:service_namespace])
    raise ArgumentError, "#{@__resource_name__}: service_namespace must be provided" unless opts[:service_namespace] && !opts[:service_namespace].empty?
    @display_name = opts[:service_namespace]
    catch_aws_errors do
      resp = @aws.applicationautoscaling_client.describe_scalable_targets({ service_namespace: opts[:service_namespace] })
      @scalable_targets = resp.scalable_targets[0].to_h
      create_resource_methods(@scalable_targets)
    end
  end

  def service_namespace
    return unless exists?
    @scalable_targets[:service_namespace]
  end

  def resource_id
    @scalable_targets? @scalable_targets[:resource_id]: ""
  end

  def exists?
    !@scalable_targets.nil? && !@scalable_targets.empty?
  end

  def encrypted?
    @scalable_targets[:encrypted]
  end

  def to_s
    "Service Namespace: #{@display_name}"
  end
end
