require "aws_backend"

class AwsEc2TransitGatewayAttachments < AwsResourceBase
  name "aws_ec2_transit_gateway_attachments"
  desc "Describes one or more attachments between resources and transit gateways. By default, all attachments are described. Alternatively, you can filter the results by attachment ID, attachment state, resource ID, or resource owner."
  example "
    describe aws_ec2_transit_gateway_attachements do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:transit_gateway_attachment_ids,                   field: :transit_gateway_attachment_id)
    .register_column(:transit_gateway_ids,                              field: :transit_gateway_id)
    .register_column(:transit_gateway_owner_ids,                        field: :transit_gateway_owner_id)
    .register_column(:resource_owner_ids,                               field: :resource_owner_id)
    .register_column(:resource_types,                                   field: :resource_type)
    .register_column(:resource_ids,                                     field: :resource_id)
    .register_column(:states,                                           field: :state)
    .register_column(:associations,                                     field: :association)
    .register_column(:creation_times,                                   field: :creation_time)
    .register_column(:tags,                                             field: :tags)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    transit_gateway_attachment_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_transit_gateway_attachments(pagination_options)
      end
      return transit_gateway_attachment_rows if !@api_response || @api_response.empty?
      @api_response.transit_gateway_attachments.each do |res|
        transit_gateway_attachment_rows += [{
          transit_gateway_attachment_id: res.transit_gateway_attachment_id,
          transit_gateway_id: res.transit_gateway_id,
          transit_gateway_owner_id: res.transit_gateway_owner_id,
          resource_owner_id: res.resource_owner_id,
          resource_type: res.resource_type,
          resource_id: res.resource_id,
          state: res.state,
          association: res.association,
          creation_time: res.creation_time,
          tags: map_tags(res[:tags]),
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = transit_gateway_attachment_rows
  end
end
