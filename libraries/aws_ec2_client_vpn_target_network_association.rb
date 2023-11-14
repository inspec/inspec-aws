require "aws_backend"

class AWSEC2ClientVPNTargetNetworkAssociation < AwsResourceBase
  name "aws_ec2_client_vpn_target_network_association"
  desc "Describes a single AWS EC2 Client Vpn Target Network Association."
  example <<-EXAMPLE
    describe aws_ec2_client_vpn_target_network_association(client_vpn_endpoint_id: 'CLIENT_VPN_ENDPOINT_ID', association_id: 'ASSOCIATION_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { client_vpn_endpoint_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i[client_vpn_endpoint_id association_id])
    unless opts[:client_vpn_endpoint_id] &&
             !opts[:client_vpn_endpoint_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: client_vpn_endpoint_id must be provided"
    end
    unless opts[:association_id] && !opts[:association_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: association_id must be provided"
    end
    @display_name = opts[:client_vpn_endpoint_id]
    filter = [{ name: "association-id", values: [opts[:association_id]] }]
    catch_aws_errors do
      resp =
        @aws.compute_client.describe_client_vpn_target_networks(
          {
            client_vpn_endpoint_id: opts[:client_vpn_endpoint_id],
            filters: filter
          }
        )
      @res = resp.client_vpn_target_networks[0].to_h
      create_resource_methods(@res)
    end
  end

  def association_id
    return nil unless exists?
    @res[:association_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def resource_id
    "#{@display_name}_#{@res ? @res[:association_id] : ""}"
  end

  def to_s
    "Association ID: #{@display_name}"
  end
end
