# frozen_string_literal: true

require 'aws_backend'

class AWSNetworkManagerCustomerGatewayAssociations < AwsResourceBase
  name 'aws_network_manager_customer_gateway_associations'
  desc 'Gets the association information for customer gateways that are associated with devices and links in your global network.'

  example "
    describe aws_network_manager_customer_gateway_associations(global_network_id: 'GlobalNetworkID') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:customer_gateway_arns, field: :customer_gateway_arn)
             .register_column(:global_network_ids, field: :global_network_id)
             .register_column(:device_ids, field: :device_id)
             .register_column(:link_ids, field: :link_id)
             .register_column(:states, field: :state)
             .register_column(:tags, field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    opts = { global_network_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:global_network_id])
    raise ArgumentError, "#{@__resource_name__}: global_network_id must be provided" unless opts[:global_network_id] && !opts[:global_network_id].empty?
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.network_manager_client.get_customer_gateway_associations(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.customer_gateway_associations.each do |resp|
        rows += [{ customer_gateway_arn: resp.customer_gateway_arn,
                   global_network_id: resp.global_network_id,
                   device_id: resp.device_id,
                   link_id: resp.link_id,
                   state: resp.state }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
