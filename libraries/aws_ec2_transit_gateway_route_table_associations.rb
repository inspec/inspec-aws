require 'aws_backend'

class AwsEc2TransitGatewayRouteTableAssociations < AwsResourceBase
  name 'aws_ec2_transit_gateway_route_table_associations'
  desc 'Gets information about the associations for the specified transit gateway route table.'
  example "
    describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: 'tgw-attach-0123456789') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:transit_gateway_attachment_ids,                   field: :transit_gateway_attachment_id)
             .register_column(:resource_ids,                                     field: :resource_id)
             .register_column(:resource_types,                                   field: :resource_type)
             .register_column(:states,                                           field: :state)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(transit_gateway_route_table_id))
    @query_params = {}
    @query_params[:transit_gateway_route_table_id] = opts[:transit_gateway_route_table_id]
    raise ArgumentError, "#{@__resource_name__}: transit_gateway_route_table_id must be provided" unless opts[:transit_gateway_route_table_id] && !opts[:transit_gateway_route_table_id].empty?
    @query_params[:transit_gateway_route_table_id] = opts[:transit_gateway_route_table_id]
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:max_results] = 1000
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.get_transit_gateway_route_table_associations(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.associations.each do |association|
        rows += [{
          transit_gateway_attachment_id: association.transit_gateway_attachment_id,
          resource_id: association.resource_id,
          resource_type: association.resource_type,
          state: association.state,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
