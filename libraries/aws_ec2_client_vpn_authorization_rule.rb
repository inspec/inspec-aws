require "aws_backend"

class AWSEC2ClientVPNAuthorizationRule < AwsResourceBase
  name "aws_ec2_client_vpn_authorization_rule"
  desc "Describes a VPN authorization rule."
  example <<-EXAMPLE
    describe aws_ec2_client_vpn_authorization_rule(client_vpn_endpoint_id: 'CLIENT_VPN_ENDPOINT_ID', group_id: 'GROUP_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { client_vpn_endpoint_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i[client_vpn_endpoint_id group_id])
    unless opts[:client_vpn_endpoint_id] &&
             !opts[:client_vpn_endpoint_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: client_vpn_endpoint_id must be provided"
    end
    unless opts[:group_id] && !opts[:group_id].empty?
      raise ArgumentError, "#{@__resource_name__}: group_id must be provided"
    end
    @display_name = opts[:client_vpn_endpoint_id]
    filter = [{ name: "group-id", values: [opts[:group_id]] }]
    catch_aws_errors do
      resp =
        @aws.compute_client.describe_client_vpn_authorization_rules(
          {
            client_vpn_endpoint_id: opts[:client_vpn_endpoint_id],
            filters: filter
          }
        )
      @res = resp.authorization_rules[0].to_h
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
    "#{@res ? @res[:client_vpn_endpoint_id] : ""}_#{@res ? @res[:group_id] : ""}"
  end

  def to_s
    "Client VPN Endpoint ID: #{@display_name}"
  end
end
