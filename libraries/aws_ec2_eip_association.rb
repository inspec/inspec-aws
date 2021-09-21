# frozen_string_literal: true

require 'aws_backend'

class AWSEC2EIPAssociation < AwsResourceBase
  name 'aws_ec2_eip_association'
  desc 'Describes the specified Elastic IP addresses or all of your Elastic IP addresses.'

  example "
    describe aws_ec2_eip_association(allocation_id: 'AllocationID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { allocation_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(allocation_id))
    raise ArgumentError, "#{@__resource_name__}: allocation_id must be provided" unless opts[:allocation_id] && !opts[:allocation_id].empty?
    @display_name = opts[:allocation_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_addresses({ allocation_ids: [opts[:allocation_id]] })
      @resp = resp.addresses[0].to_h
      create_resource_methods(@resp)
    end
  end

  def allocation_id
    return nil unless exists?
    @resp[:allocation_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "Allocation Id: #{@display_name}"
  end
end