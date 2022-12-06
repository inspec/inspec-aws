require 'aws_backend'

class AWSEc2TransitGatewayRouteTablePropagations < AwsResourceBase
  name 'aws_ec2_transit_gateway_route_table_propagations'
  desc 'List information about the route table propagations for the specified transit gateway route table.'

  example "
    describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'test1') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:transit_gateway_attachment_ids,              field: :transit_gateway_attachment_id)
             .register_column(:resource_ids,                                field: :resource_id)
             .register_column(:resource_types,                              field: :resource_type)
             .register_column(:states,                                      field: :state)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(transit_gateway_route_table_id))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: transit_gateway_route_table_id must be provided" unless opts[:transit_gateway_route_table_id] && !opts[:transit_gateway_route_table_id].empty?
    @query_params[:transit_gateway_route_table_id] = opts[:transit_gateway_route_table_id]
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.get_transit_gateway_route_table_propagations(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.transit_gateway_route_table_propagations.each do |resp|
        rows += [{ transit_gateway_attachment_id: resp.transit_gateway_attachment_id,
                   resource_id: resp.resource_id,
                   resource_type: resp.resource_type,
                   state: resp.state }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    rows
  end
end
