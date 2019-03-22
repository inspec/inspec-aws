# frozen_string_literal: true

require 'aws_backend'

class AwsVpc < AwsResourceBase
  name 'aws_vpc'
  desc 'Verifies settings for an AWS VPC'

  example "
    describe aws_vpc(vpc_id: 'vpc-12345678') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { vpc_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(allow: [:vpc_id])

    if opts[:vpc_id].nil?
      @display_name = 'default'
      filter = { name: 'isDefault', values: ['true'] }
    else
      @display_name = opts[:vpc_id]
      raise ArgumentError, "#{@__resource_name__}: VPC ID must be in the format 'vpc-' followed by 8 or 17 hexadecimal characters." if opts[:vpc_id] !~ /^vpc\-([0-9a-f]{8})|(^vpc\-[0-9a-f]{17})$/
      filter = { name: 'vpc-id', values: [opts[:vpc_id]] }
    end

    catch_aws_errors do
      resp = @aws.compute_client.describe_vpcs({ filters: [filter] })
      @vpc = resp.vpcs[0].to_h
      create_resource_methods(@vpc)
    end
  end

  def default?
    @vpc[:is_default]
  end

  def exists?
    !@vpc.empty?
  end

  def available?
    return false unless exists?
    @vpc[:state] == 'available'
  end

  def to_s
    opts.key?(:aws_region) ? "VPC #{@display_name} in #{opts[:aws_region]}" : "VPC #{@display_name}"
  end
end
