# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2VPCLinks < AwsResourceBase
  name 'aws_api_gatewayv2_vpc_links'
  desc 'Gets a collection of VPC links.'

  example "
    describe aws_api_gatewayv2_vpc_links do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:created_dates, field: :created_date)
             .register_column(:names, field: :name)
             .register_column(:security_group_ids, field: :security_group_ids)
             .register_column(:subnet_ids, field: :subnet_ids)
             .register_column(:tags, field: :tags)
             .register_column(:vpc_link_ids, field: :vpc_link_id)
             .register_column(:vpc_link_statuses, field: :vpc_link_status)
             .register_column(:vpc_link_status_messages, field: :vpc_link_status_message)
             .register_column(:vpc_link_versions, field: :vpc_link_version)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = '100'
    loop do
      catch_aws_errors do
        @api_response = @aws.apigatewayv2_client.get_vpc_links(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.vpc_peering_connections.each do |resp|
        rows += [{ created_date: resp.created_date,
                   name: resp.name,
                   security_group_ids: resp.security_group_ids,
                   subnet_ids: resp.subnet_ids,
                   tags: resp.tags,
                   vpc_link_id: resp.vpc_link_id,
                   vpc_link_status: resp.vpc_link_status,
                   vpc_link_status_message: resp.vpc_link_status_message,
                   vpc_link_version: resp.vpc_link_version }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
