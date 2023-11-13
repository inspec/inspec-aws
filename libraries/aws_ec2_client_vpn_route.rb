require 'aws_backend'

class AWSEC2ClientVPNRoute < AwsResourceBase
  name 'aws_ec2_client_vpn_route'
  desc 'Describes a VPN route.'
  example <<-EXAMPLE
    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: 'CLIENT_VPN_ENDPOINT_ID', target_subnet: 'TARGET_SUBNET') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { client_vpn_endpoint_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(client_vpn_endpoint_id target_subnet))
    raise ArgumentError, "#{@__resource_name__}: client_vpn_endpoint_id must be provided" unless opts[:client_vpn_endpoint_id] && !opts[:client_vpn_endpoint_id].empty?
    raise ArgumentError, "#{@__resource_name__}: target_subnet must be provided" unless opts[:target_subnet] && !opts[:target_subnet].empty?
    @display_name = opts[:client_vpn_endpoint_id]
    filter = [{ name: 'target-subnet',
                values: [opts[:target_subnet]] }]
    catch_aws_errors do
      resp = @aws.compute_client.describe_client_vpn_routes({ client_vpn_endpoint_id: opts[:client_vpn_endpoint_id], filters: filter })
      @res = resp.routes[0].to_h
      create_resource_methods(@res)
    end
  end

  def client_vpn_endpoint_id
    return unless exists?
    @res[:client_vpn_endpoint_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def resource_id
    "#{@res ? @res[:client_vpn_endpoint_id] : ''}_#{@res ? @res[:target_subnet] : ''}"
  end

  def to_s
    "Client VPN Endpoint ID: #{@display_name}"
  end
end
