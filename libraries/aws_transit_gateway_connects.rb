require "aws_backend"

class AWSTransitGatewayConnects < AwsResourceBase
  name "aws_transit_gateway_connects"
  desc "Describes one or more Connect attachments."

  example "
    describe aws_transit_gateway_connects do
      it { should exist }
    end

    describe aws_transit_gateway_connects do
      its('transit_gateway_attachment_ids') { should include 'tgw-attach-1234567890' }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:transit_gateway_attachment_ids,                  field: :transit_gateway_attachment_id)
    .register_column(:transport_transit_gateway_attachment_ids,        field: :transport_transit_gateway_attachment_id)
    .register_column(:transit_gateway_ids,                             field: :transit_gateway_id)
    .register_column(:states,                                          field: :state)
    .register_column(:creation_times,                                  field: :creation_time)
    .register_column(:options,                                         field: :options)
    .register_column(:creation_times,                                  field: :creation_time)
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
        @api_response = @aws.compute_client.describe_transit_gateway_connects(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.transit_gateway_connects.each do |resp|
        rows += [{ transit_gateway_attachment_id: resp.transit_gateway_attachment_id,
                   transport_transit_gateway_attachment_id: resp.transport_transit_gateway_attachment_id,
                   transit_gateway_id: resp.transit_gateway_id,
                   state: resp.state,
                   creation_time: resp.creation_time,
                   options: resp.options,
                   tags: resp.tags }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end
