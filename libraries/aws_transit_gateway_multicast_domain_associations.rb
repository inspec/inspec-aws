# frozen_string_literal: true

require 'aws_backend'

class AWSTransitGatewayMulticastDomainAssociations < AwsResourceBase
  name 'aws_transit_gateway_multicast_domain_associations'
  desc 'Gets information about the associations for the transit gateway multicast domain.'

  example "
    describe aws_transit_gateway_multicast_domain_associations do
      it { should exist }
    end

    describe aws_transit_gateway_multicast_domain_associations do
      its('transit_gateway_attachment_ids') { should include 'Domain ID' }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:transit_gateway_attachment_id,                   field: :transit_gateway_attachment_id)
             .register_column(:resource_ids,                                    field: :resource_id)
             .register_column(:resource_types,                                  field: :resource_type)
             .register_column(:resource_owner_ids,                              field: :resource_owner_id)
             .register_column(:subnets,                                         field: :subnet)
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
        @api_response = @aws.compute_client.describe_transit_gateway_multicast_domains(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.transit_gateway_multicast_domains.each do |resp|
        rows += [{ transit_gateway_attachment_id: resp.transit_gateway_attachment_id,
                   resource_id: resp.resource_id,
                   resource_type: resp.resource_type,
                   resource_owner_id: resp.resource_owner_id,
                   subnet: resp.subnet }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
