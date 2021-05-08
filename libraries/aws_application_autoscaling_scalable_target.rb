# frozen_string_literal: true

require 'aws_backend'

class AWSApplicationAutoScalingScalableTarget < AwsResourceBase
  name 'aws_application_autoscaling_scalable_target'
  desc 'Gets information about the scalable targets in the specified namespace.'

  example "
    describe aws_application_autoscaling_scalable_target(resource_id: '') do
      it { should eq '' }
    end

    describe aws_application_autoscaling_scalable_target(resource_id: '') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { resource_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:resource_id])

    raise ArgumentError, "#{@__resource_name__}: resource_id must be provided" unless opts[:resource_id] && !opts[:resource_id].empty?
    @display_name = opts[:resource_id]
    require "pry"; binding.pry
    catch_aws_errors do
      resp = @aws.applicationautoscaling_client.describe_scalable_targets({ resource_id: [opts[:resource_id]] })
      @scalable_targets = resp.scalable_targets[0].to_h
      create_resource_methods(@scalable_targets)
    end
  end

  def id
    return nil unless exists?
    @scalable_targets[:resource_id]
  end

  def exists?
    !@scalable_targets.nil? && !@scalable_targets.empty?
  end

  def encrypted?
    @scalable_targets[:encrypted]
  end

  def to_s
    "EIP #{@display_name}"
  end
end
