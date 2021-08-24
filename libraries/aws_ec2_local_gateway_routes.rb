# frozen_string_literal: true

require 'aws_backend'

class AWSEC2LocalGatewayRoutes < AwsResourceBase
  name 'aws_ec2_local_gateway_routes'
  desc 'List all the local gateway routes.'

  example "
    describe aws_ec2_local_gateway_route do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:destination_cidr_blocks, field: :destination_cidr_block)
             .register_column(:local_gateway_virtual_interface_group_ids, field: :local_gateway_virtual_interface_group_id)
             .register_column(:types, field: :type)
             .register_column(:states, field: :state)
             .register_column(:local_gateway_route_table_ids, field: :local_gateway_route_table_id)
             .register_column(:local_gateway_route_table_arns, field: :local_gateway_route_table_arn)
             .register_column(:owner_ids, field: :owner_id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = 100
    pagination_options[:filters] = { name: 'local-gateway-route-table-id', values: [opts[:local_gateway_route_table_id]] }
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.search_local_gateway_routes(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.routes.each do |resp|
        rows += [{ destination_cidr_block: resp.destination_cidr_block,
                   local_gateway_virtual_interface_group_id: resp.local_gateway_virtual_interface_group_id,
                   type: resp.type,
                   state: resp.state,
                   local_gateway_route_table_id: resp.local_gateway_route_table_id,
                   local_gateway_route_table_arn: resp.local_gateway_route_table_arn,
                   owner_id: resp.owner_id }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
