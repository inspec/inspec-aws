require "aws_backend"

class AwsTransitGatewayRoutes < AwsResourceBase
  TYPES = %w{static propagated}.freeze
  SUPPORTED_FILTER_PARAMS = %i(exact_match longest_prefix_match subnet_of_match supernet_of_match).freeze
  name "aws_transit_gateway_routes"
  desc "Verifies settings for list of AWS Transit Gateways."

  example "
    describe aws_transit_gateway_routes(transit_gateway_route_table_id: 'tgw-rtb-08acd74550c99e589') do
      it { should exist }
    end

    describe aws_transit_gateway_routes(transit_gateway_route_table_id: 'tgw-rtb-08acd74550c99e589', exact_match: '0.0.0.0/16') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:cidr_blocks, field: :cidr_block)
    .register_column(:prefix_list_ids, field: :prefix_list_id)
    .register_column(:types, field: :type, style: :simple)
    .register_column(:states, field: :state, style: :simple)
    .register_column(:static, field: :static, style: :simple)
    .register_column(:propagated, field: :propagated, style: :simple)
    .register_column(:active, field: :active, style: :simple)
    .register_column(:blackhole, field: :blackhole, style: :simple)
    .register_column(:attachment_ids, field: :attachment_id, style: :simple)
    .register_column(:attachment_resource_ids, field: :attachment_resource_id, style: :simple)
    .register_column(:attachment_resource_types, field: :attachment_resource_type, style: :simple)
    .register_column(:attached_vpc_ids, field: :attached_vpc_id, style: :simple)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts)
    super
    validate_parameters(required: %i(transit_gateway_route_table_id),
                        allow: %i(exact_match longest_prefix_match subnet_of_match supernet_of_match))
    raise ArgumentError, "#{@__resource_name__}:ID must be in the format 'tgw-rtb-' followed by hexadecimal characters." if @opts[:transit_gateway_route_table_id] !~ /^tgw\-rtb\-([0-9a-z]*)$/
    fetch_response
    populate_filter_table
  end

  def exists?
    !failed_resource? && !!routes && !routes.empty?
  end

  def to_s
    "Transit Gateway Routes for Route Table #{@opts[:transit_gateway_route_table_id]}"
  end

  private

  attr_reader :routes

  def fetch_response
    params = { transit_gateway_route_table_id: @opts[:transit_gateway_route_table_id], max_results: 1000 }.tap do |hash|
      hash[:filters] = if (SUPPORTED_FILTER_PARAMS & @opts.keys).empty?
                         default_filters
                       else
                         build_filters_from_params
                       end
    end
    @routes = Set.new
    loop do
      params[:max_results] += 1000 if @response&.additional_routes_available

      catch_aws_errors do
        @response = @aws.compute_client.search_transit_gateway_routes(params)
        @response.routes.each { |route| @routes << route }
      end
      break unless @response&.additional_routes_available
    end
  end

  def populate_filter_table
    @table = routes.map do |route|
      row = route.to_h
      row[:cidr_block] = row.delete(:destination_cidr_block)
      row[:static] = (row[:type] == "static")
      row[:propagated] = (row[:type] == "propagated")
      row[:active] = (row[:state] == "active")
      row[:blackhole] = (row[:state] == "blackhole")
      tgw = transit_gw_attachment_for(route)
      row[:attachment_id] = tgw&.transit_gateway_attachment_id
      row[:attachment_resource_type] = tgw&.resource_type
      row[:attachment_resource_id] = tgw&.resource_id
      row[:attached_vpc_id] = (row[:attachment_resource_type] == "vpc" && row[:attachment_resource_id])
      row.delete(:transit_gateway_attachments)
      row
    end
  end

  def transit_gw_attachment_for(route)
    return if route.transit_gateway_attachments.empty?

    route.transit_gateway_attachments.first
  end

  def format_route_search_for(param)
    format("route-search.%s", param.to_s.gsub("_", "-"))
  end

  def build_filters_from_params
    @opts.each_with_object([]) do |(param, value), array|
      next unless SUPPORTED_FILTER_PARAMS.include?(param)
      array << { name: format_route_search_for(param), values: [value] }
    end
  end

  def default_filters
    [
      name: "type",
      values: TYPES,
    ]
  end
end
