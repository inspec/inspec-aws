# frozen_string_literal: true

require 'aws_backend'

class AWSEC2VPNConnectionRoute < AwsResourceBase
  name 'aws_ec2_vpn_connection_route'
  desc 'Describes one or more of your VPN connections route.'

  example "
    describe aws_ec2_vpn_connection_route(vpn_connection_id: 'VPNConnectionID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { vpn_connection_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:vpn_connection_id])
    raise ArgumentError, "#{@__resource_name__}: vpn_connection_id must be provided" unless opts[:vpn_connection_id] && !opts[:vpn_connection_id].empty?
    @display_name = opts[:vpn_connection_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_vpn_connections({ vpn_connection_ids: [opts[:vpn_connection_id]] })
      @res = resp.vpn_connections[0].routes[0].to_h
      create_resource_methods(@res)
    end
  end

  def vpn_connection_id
    return nil unless exists?
    @res[:vpn_connection_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "VPN Connection ID: #{@display_name}"
  end
end
