# frozen_string_literal: true

require 'aws_backend'

class AWSApplicationAutoScalingScalingPolicy < AwsResourceBase
  name 'aws_application_autocaling_scaling_policy'
  desc 'Describes the scaling policies for the ECS service namespace.'

  example "
    describe aws_application_autocaling_scaling_policy(public_ip: '192.0.2.0') do
      it { should eq '192.0.2.0' }
    end

    describe aws_application_autocaling_scaling_policy(public_ip: '192.0.2.0') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { public_ip: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:public_ip])

    raise ArgumentError, "#{@__resource_name__}: public_ip must be provided" unless opts[:public_ip] && !opts[:public_ip].empty?
    @display_name = opts[:public_ip]
    catch_aws_errors do
      resp = @aws.applicationautoscaling_client.describe_addresses({ public_ips: [opts[:public_ip]] })
      @addresses = resp.addresses[0].to_h
      create_resource_methods(@addresses)
    end
  end

  def id
    return nil unless exists?
    @addresses[:public_ip]
  end

  def exists?
    !@addresses.nil? && !@addresses.empty?
  end

  def encrypted?
    @addresses[:encrypted]
  end

  def to_s
    "EIP #{@display_name}"
  end
end
