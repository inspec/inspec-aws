require "aws_backend"

class AWSApiGatewayVPCLink < AwsResourceBase
  name "aws_api_gateway_vpc_link"
  desc "Gets a specified VPC link under the callers account in a region."
  example <<-EXAMPLE
    describe aws_api_gateway_vpc_link(vpc_link_id: 'VPC_LINK_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { vpc_link_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(vpc_link_id))
    raise ArgumentError, "#{@__resource_name__}: vpc_link_id must be provided" if opts[:vpc_link_id].blank?
    @display_name = opts[:vpc_link_id]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_vpc_link({ vpc_link_id: opts[:vpc_link_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def resource_id
    @res? "#{@res[:id]}_#{@res[:name]}" : @display_name
  end

  def exists?
    !@res.blank?
  end

  def vpc_link_id
    return unless exists?
    @res[:id]
  end

  def to_s
    "VPC Link ID: #{@display_name}"
  end
end
