# frozen_string_literal: true

require 'aws_backend'

class AWSEc2VPNConnectionRoute < AwsResourceBase
  name 'aws_ec2_vpn_connection_route'
  desc 'Specifies a static route for a VPN connection between an existing virtual private gateway and a VPN customer gateway.'

  example "
    describe aws_ec2_vpn_connection_route(vpn_connection_id: 'vpn-1234567890') do
      it { should exist }
    end

    describe aws_ec2_vpn_connection_route(vpn_connection_id: 'vpn-1234567890') do
      its ('state') { should eq 'available }
    end
  "

  def initialize(opts = {})
    opts = { vpn_connection_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:vpn_connection_id])
    raise ArgumentError, "#{@__resource_name__}: transit_gateway_route_table_id must be provided" unless opts[:vpn_connection_id] && !opts[:vpn_connection_id].empty?
    @display_name = opts[:vpn_connection_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_vpn_connections({ vpn_connection_ids: [opts[:vpn_connection_id]] })
      @vpn_connections = resp.vpn_connections[0].routes[0].to_h
      create_resource_methods(@vpn_connections)
    end
  end

  def vpn_connection_id
    return nil unless exists?
    @vpn_connections[:vpn_connection_id]
  end

  def exists?
    !@vpn_connections.nil? && !@vpn_connections.empty?
  end

  def to_s
    "VPN Connection ID: #{@display_name}"
  end
end