require "aws_backend"

class AwsFlowLog < AwsResourceBase
  name "aws_flow_log"
  desc "Verifies settings for an AWS VPC flow logs."

  example "
    describe aws_flow_log('fl-9c718cf5') do
      it { should exist }
    end
  "
  attr_reader :log_group_name, :resource_id, :flow_log_id

  def initialize(opts = {})
    opts = { flow_log_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(require_any_of: %i(flow_log_id subnet_id vpc_id))

    query = { filter: [{ name: "flow-log-id", values: [opts[:flow_log_id]] }] } if opts[:flow_log_id]
    query = { filter: [{ name: "resource-id", values: [opts[:subnet_id]] }] } if opts[:subnet_id]
    query = { filter: [{ name: "resource-id", values: [opts[:vpc_id]] }] } if opts[:vpc_id]

    catch_aws_errors do
      resp = @aws.compute_client.describe_flow_logs(query)
      flow_log = resp.to_h[:flow_logs].first

      return if flow_log.nil?

      @log_group_name = flow_log[:log_group_name]
      @resource_id    = flow_log[:resource_id]
      @flow_log_id    = flow_log[:flow_log_id]
    end
  end

  def resource_type
    case @resource_id
    when /^eni/
      @resource_type = "eni"
    when /^subnet/
      @resource_type = "subnet"
    when /^vpc/
      @resource_type = "vpc"
    end
  end

  def attached_to_eni?
    resource_type.eql?("eni")
  end

  def attached_to_subnet?
    resource_type.eql?("subnet")
  end

  def attached_to_vpc?
    resource_type.eql?("vpc")
  end

  def exists?
    !@flow_log_id.nil?
  end

  def to_s
    opts.key?(:aws_region) ? "AWS Flow Log #{id} in #{opts[:aws_region]}" : "AWS Flow Log #{id}"
  end

  private

  def id
    return @flow_log_id if @flow_log_id
    return "for Subnet #{opts[:subnet_id]}" if opts[:subnet_id]
    return "for VPC #{opts[:vpc_id]}" if opts[:vpc_id]
  end
end
