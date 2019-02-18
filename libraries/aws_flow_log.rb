# frozen_string_literal: true

require 'aws_backend'

class AwsFlowLog < AwsResourceBase
  name 'aws_flow_log'
  desc 'Verifies settings for an AWS VPC'

  example "
    describe aws_flow_log('fl-9c718cf5') do
      it { should exist }
    end
  "
  attr_reader :log_group_name, :resource_id, :flow_log_id, :exists
  alias exists? exists

  def initialize(opts = {})
    # Call the parent class constructor
    opts = { flow_log_id: opts } if opts.is_a?(String) # this preserves the original scalar interface
    super(opts)
    validate_parameters(%i(flow_log_id subnet_id vpc_id))
    query = { filter: [{ name: 'flow-log-id', values: [opts[:flow_log_id]] }] } if opts[:flow_log_id]
    query = { filter: [{ name: 'resource-id', values: [opts[:subnet_id]] }] } if opts[:subnet_id]
    query = { filter: [{ name: 'resource-id', values: [opts[:vpc_id]] }] } if opts[:vpc_id]
    raise ArgumentError, 'Must specify flow_log_id, subnet_id or vpc_id' if query.nil?
    catch_aws_errors do
      @resp = @aws.compute_client.describe_flow_logs(query)
      flow_log = @resp.to_h[:flow_logs].first
      @exists = !flow_log.nil?
      unless flow_log.nil?
        @log_group_name = flow_log[:log_group_name]
        @resource_id = flow_log[:resource_id]
        @flow_log_id = flow_log[:flow_log_id]
      end
    end
  end

  def id
    return @flow_log_id if @flow_log_id
    return "for Subnet #{opts[:subnet_id]}" if opts[:subnet_id]
    return "for VPC #{opts[:vpc_id]}" if opts[:vpc_id]
  end

  def resource_type
    case @resource_id
    when /^eni/
      @resource_type = 'eni'
    when /^subnet/
      @resource_type = 'subnet'
    when /^vpc/
      @resource_type = 'vpc'
    end
  end

  def attached_to_eni?
    resource_type.eql?('eni') ? true : false
  end

  def attached_to_subnet?
    resource_type.eql?('subnet') ? true : false
  end

  def attached_to_vpc?
    resource_type.eql?('vpc') ? true : false
  end

  def to_s
    opts.key?(:aws_region) ? "AWS Flow Log #{id} in #{opts[:aws_region]}" : "AWS Flow Log #{id}"
  end
end
