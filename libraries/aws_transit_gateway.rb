require "aws_backend"

class AwsTransitGateway < AwsResourceBase
  name "aws_transit_gateway"
  desc "Verifies settings for an AWS Transit Gateway."

  example "
    describe aws_transit_gateway('TRANSIT_GATEWAY_ID') do
      it { should exist }
    end
  "

  attr_reader :transit_gateway_arn, :transit_gateway_id, :transit_gateway_owner_id,
              :default_route_table_id, :propagation_default_route_table_id,
              :vpn_ecmp_support, :dns_support

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: [:transit_gateway_id])

    catch_aws_errors do
      resp = @aws.compute_client.describe_transit_gateways(transit_gateway_ids: [opts[:transit_gateway_id]])
      return if resp.transit_gateways.nil? || resp.transit_gateways.empty?
      transit_gateway = resp.transit_gateways.first
      @transit_gateway_arn                                      = transit_gateway.transit_gateway_arn
      @transit_gateway_id                                       = transit_gateway.transit_gateway_id
      @transit_gateway_owner_id                                 = transit_gateway.owner_id
      @default_route_table_id                                   = transit_gateway.options.association_default_route_table_id
      @propagation_default_route_table_id                       = transit_gateway.options.propagation_default_route_table_id
      @dns_support                                              = transit_gateway.options.dns_support
      @vpn_ecmp_support                                         = transit_gateway.options.vpn_ecmp_support
    end
  end

  def exists?
    !@transit_gateway_id.nil?
  end

  def resource_id
    @transit_gateway_arn
  end

  def to_s
    "AWS Transit Gateway ID: #{@transit_gateway_id}"
  end
end
