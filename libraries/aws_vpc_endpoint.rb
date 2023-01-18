require "aws_backend"

class AwsVpce < AwsResourceBase
  name "aws_vpc_endpoint"
  desc "Verifies settings for an AWS VPC Endpoint."

  example "
    describe aws_vpc_endpoint(vpc_endpoint_id: 'vpce-12345678123456789') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { vpc_endpoint_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:vpc_endpoint_id])

    if opts[:vpc_endpoint_id] !~ /(^vpce\-[0-9a-f]{17}$)|(^vpce\-[0-9a-f]{8}$)/
      raise ArgumentError, "#{@__resource_name__}: 'vpc_endpoint_id' must be in the format 'vpce-' followed by 8 hexadecimal characters."
    end

    @display_name = opts[:vpc_endpoint_id]
    filter = { name: "vpc-endpoint-id", values: [opts[:vpc_endpoint_id]] }
    catch_aws_errors do
      resp = @aws.compute_client.describe_vpc_endpoints({ filters: [filter] })
      @vpce = resp.vpc_endpoints[0].to_h
      create_resource_methods(@vpce)
    end
  end

  def exists?
    !@vpce.empty?
  end

  def available?
    return false unless exists?
    @vpce[:state] == "available"
  end

  def private_dns_enabled?
    @vpce[:private_dns_enabled]
  end

  def interface?
    return false unless exists?
    @vpce[:vpc_endpoint_type] == "Interface"
  end

  def gateway?
    return false unless exists?
    @vpce[:vpc_endpoint_type] == "Gateway"
  end

  def resource_id
    @vpce ? @vpce[:vpc_endpoint_id] : @display_name
  end

  def to_s
    "VPC Endpoint: #{@display_name}"
  end
end
