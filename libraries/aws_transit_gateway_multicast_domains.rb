require 'aws_backend'

class AWSTransitGatewayMulticastDomains < AwsResourceBase
  name 'aws_transit_gateway_multicast_domains'
  desc 'Describes one or more transit gateway multicast domains.'

  example "
    describe aws_transit_gateway_multicast_domains do
      it { should exist }
    end

    describe aws_transit_gateway_multicast_domains do
      its('transit_gateway_multicast_domain_ids') { should include 'Domain ID' }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:transit_gateway_multicast_domain_ids,            field: :transit_gateway_multicast_domain_id)
             .register_column(:transit_gateway_ids,                             field: :transit_gateway_id)
             .register_column(:transit_gateway_multicast_domain_arns,           field: :transit_gateway_multicast_domain_arn)
             .register_column(:owner_ids,                                       field: :owner_id)
             .register_column(:options,                                         field: :options)
             .register_column(:states,                                          field: :state)
             .register_column(:creation_time,                                   field: :creation_time)
             .register_column(:tags,                                            field: :tags)
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
        rows += [{ transit_gateway_multicast_domain_id: resp.transit_gateway_multicast_domain_id,
                   transit_gateway_id: resp.transit_gateway_id,
                   transit_gateway_multicast_domain_arn: resp.transit_gateway_multicast_domain_arn,
                   owner_id: resp.owner_id,
                   options: resp.options,
                   state: resp.state,
                   creation_time: resp.creation_time,
                   tags: resp.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
