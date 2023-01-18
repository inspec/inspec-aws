require "aws_backend"

class AwsEc2TransitGatewayRouteTables < AwsResourceBase
  name "aws_ec2_transit_gateway_route_tables"
  desc "Describes one or more transit gateway route tables. By default, all transit gateway route tables are described. Alternatively, you can filter the results."

  example "
    describe aws_ec2_transit_gateway_route_tables do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:transit_gateway_route_table_ids,                  field: :transit_gateway_route_table_id)
    .register_column(:transit_gateway_ids,                              field: :transit_gateway_id)
    .register_column(:states,                                           field: :state)
    .register_column(:default_association_route_tables,                 field: :default_association_route_table)
    .register_column(:default_propagation_route_tables,                 field: :default_propagation_route_table)
    .register_column(:creation_times,                                   field: :creation_time)
    .register_column(:tags,                                             field: :tags)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    transit_gateway_route_table_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_transit_gateway_route_tables(pagination_options)
      end
      return transit_gateway_route_table_rows if !@api_response || @api_response.empty?
      @api_response.transit_gateway_route_tables.each do |res|
        transit_gateway_route_table_rows += [{
          transit_gateway_route_table_id: res.transit_gateway_route_table_id,
          transit_gateway_id: res.transit_gateway_id,
          state: res.state,
          default_association_route_table: res.default_association_route_table,
          default_propagation_route_table: res.default_propagation_route_table,
          creation_time: res.creation_time,
          tags: map_tags(res[:tags]),
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = transit_gateway_route_table_rows
  end
end
