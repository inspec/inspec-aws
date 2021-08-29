# frozen_string_literal: true

require 'aws_backend'

class AWSEC2LocalGatewayRouteTableVPCAssociations < AwsResourceBase
  name 'aws_ec2_local_gateway_route_table_vpc_associations'
  desc 'List all the associations between VPCs and local gateway route tables..'

  example "
    describe aws_ec2_local_gateway_route_table_vpc_associations do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:local_gateway_route_table_vpc_association_ids, field: :local_gateway_route_table_vpc_association_id)
             .register_column(:local_gateway_route_table_ids, field: :local_gateway_route_table_id)
             .register_column(:local_gateway_route_table_arns, field: :local_gateway_route_table_arn)
             .register_column(:local_gateway_ids, field: :local_gateway_id)
             .register_column(:vpc_ids, field: :vpc_id)
             .register_column(:owner_ids, field: :owner_id)
             .register_column(:states, field: :state)
             .register_column(:tags, field: :tags)
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
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_local_gateway_route_table_vpc_associations(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.local_gateway_route_table_vpc_associations.each do |resp|
        rows += [{ local_gateway_route_table_vpc_association_id: resp.local_gateway_route_table_vpc_association_id,
                   local_gateway_route_table_id: resp.local_gateway_route_table_id,
                   local_gateway_route_table_arn: resp.local_gateway_route_table_arn,
                   local_gateway_id: resp.local_gateway_id,
                   vpc_id: resp.vpc_id,
                   owner_id: resp.owner_id,
                   state: resp.state,
                   tags: resp.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
