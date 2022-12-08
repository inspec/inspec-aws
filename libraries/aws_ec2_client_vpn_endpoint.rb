require "aws_backend"

class AWSEC2ClientVPNEndpoint < AwsResourceBase
  name "aws_ec2_client_vpn_endpoint"
  desc "Describes a VPN endpoint."

  example "
    describe aws_ec2_client_vpn_endpoint(client_vpn_endpoint_id: 'CLIENT_VPN_ENDPOINT_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { client_vpn_endpoint_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:client_vpn_endpoint_id])
    raise ArgumentError, "#{@__resource_name__}: client_vpn_endpoint_id must be provided" unless opts[:client_vpn_endpoint_id] && !opts[:client_vpn_endpoint_id].empty?
    @display_name = opts[:client_vpn_endpoint_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_client_vpn_endpoints({ client_vpn_endpoint_ids: [opts[:client_vpn_endpoint_id]] })
      @res = resp.client_vpn_endpoints[0].to_h
      create_resource_methods(@res)
    end
  end

  def client_vpn_endpoint_id
    return nil unless exists?
    @res[:client_vpn_endpoint_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def resource_id
    @res ? @res[:client_vpn_endpoint_id] : ""
  end

  def to_s
    "Client VPN Endpoint ID: #{@display_name}"
  end
end
