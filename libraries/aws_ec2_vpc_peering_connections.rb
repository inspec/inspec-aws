# frozen_string_literal: true

require 'aws_backend'

class AWSEc2VPCPeeringConnections < AwsResourceBase
  name 'aws_ec2_vpc_peering_connections'
  desc 'Describes one or more of your VPC peering connections.'

  example "
    describe aws_ec2_vpc_peering_connections do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:accepter_vpc_infos, field: :accepter_vpc_info)
             .register_column(:expiration_times, field: :expiration_time)
             .register_column(:requester_vpc_infos, field: :requester_vpc_info)
             .register_column(:statuses, field: :status)
             .register_column(:tags, field: :tags)
             .register_column(:vpc_peering_connection_ids, field: :vpc_peering_connection_id)
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
        @api_response = @aws.compute_client.describe_vpc_peering_connections(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.vpc_peering_connections.map do |vpc_peering_connection|
        rows += [{ accepter_vpc_info: vpc_peering_connection.accepter_vpc_info,
                   expiration_time: vpc_peering_connection.expiration_time,
                   requester_vpc_info: vpc_peering_connection.requester_vpc_info,
                   status: vpc_peering_connection.status,
                   tags: vpc_peering_connection.tags,
                   vpc_peering_connection_id: vpc_peering_connection.vpc_peering_connection_id }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = rows
  end
end
