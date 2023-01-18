require "aws_backend"

class AwsTransitGatewayRoute < AwsResourceBase
  STATES = %w{active blackhole}.freeze
  TYPES = %w{static propagated}.freeze
  ATTACHMENT_RESOURCE_TYPES = %w{vpc vpn direct-connect-gateway connect peering tgw-peering}.freeze
  name "aws_transit_gateway_route"
  desc "Verifies settings for an AWS Transit Gateway."

  example "
    describe aws_transit_gateway_route(transit_gateway_route_table_id: 'tgw-rtb-08acd74550c99e589', cidr_block: '0.0.0.0/16') do
      it { should exist }
    end
  "
  # defines boolean matchers for each state
  STATES.each do |state|
    method_name = "#{state}?"
    define_method method_name do
      route.state == state
    end
  end

  TYPES.each do |type|
    method_name = "#{type}?"
    define_method method_name do
      route.type == type
    end
  end

  ATTACHMENT_RESOURCE_TYPES.each do |resource_type|
    resource_type_name = resource_type.gsub("-", "_")
    method_name = "#{resource_type_name}_attachment?"
    define_method method_name do
      attachment_resource_type == resource_type
    end
  end

  def initialize(opts)
    super
    validate_parameters(required: %i(transit_gateway_route_table_id cidr_block))
    raise ArgumentError, "#{@__resource_name__}:ID must be in the format 'tgw-rtb-' followed by hexadecimal characters." if @opts[:transit_gateway_route_table_id] !~ /^tgw\-rtb\-([0-9a-z]*)$/
    @display_name = @opts[:transit_gateway_route_table_id]
    fetch_response
    create_instance_methods
  end

  def exists?
    !failed_resource? && !!route && !route.empty?
  end

  def resource_id
    @response ? @display_name : ""
  end

  def to_s
    "Transit Gateway Route for Route Table ID #{@opts[:transit_gateway_route_table_id]} and matching CIDR #{@opts[:cidr_block]}"
  end

  private

  def create_instance_methods
    route_hash = route.to_h
    route_hash[:cidr_block] = route_hash.delete(:destination_cidr_block)
    route_hash[:attachment_resource_id] = transit_gateway_attachment&.resource_id
    route_hash[:attachment_id] = transit_gateway_attachment&.transit_gateway_attachment_id
    route_hash[:attachment_resource_type] = transit_gateway_attachment&.resource_type
    route_hash.delete(:transit_gateway_attachments)
    create_resource_methods(route_hash)
  end

  def fetch_response
    params = {
      transit_gateway_route_table_id: @opts[:transit_gateway_route_table_id],
      filters: [
        {
          name: "route-search.exact-match",
          values: [@opts[:cidr_block]],
        },
      ],
    }
    catch_aws_errors do
      @response = @aws.compute_client.search_transit_gateway_routes(params)
    end
  end

  def route
    raise StandardError, "More than One Route is available" if @response.additional_routes_available

    @response.routes.first
  end

  def transit_gateway_attachment
    return unless route

    route.transit_gateway_attachments&.first
  end
end
