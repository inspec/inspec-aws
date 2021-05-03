require 'aws_backend'

class AwsEc2TransitGatewayRouteTableAssociations < AwsResourceBase
  name 'aws_ec2_transit_gateway_routetable_associations'
  desc 'Gets information about the associations for the specified transit gateway route table.'
  example `
    describe aws_ec2_transit_gateway_routetable_associations do
      it { should exist }
    end
  `
attr_reader :table

  FilterTable.create
            .register_column(:transit_gateway_route_table_ids,                  field: :transit_gateway_route_table_id)
            .register_column(:transit_gateway_attachment_ids,                   field: :transit_gateway_attachment_id)
            .register_column(:resource_ids,                                     field: :resource_id)
            .register_column(:resource_types,                                   field: :resource_type)
            .register_column(:states,                                           field: :state)
            .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end
          
  def fetch_data
    association_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.get_transit_gateway_route_table_associations(pagination_options)
      end
      return [] if !@api_response || @api_response.empty?
      @api_response.transit_gateway_attachments.each do |res|
        association_rows += [{
            transit_gateway_route_table_id: res.transit_gateway_route_table_id,
            transit_gateway_attachment_id: res.transit_gateway_attachment_id,
            resource_id: res.resource_id,
            resource_type: res.resource_type,
            state: res.state,
        }]
        end
        break unless @api_response.next_token
        pagination_options = { next_token: @api_response.next_token }
      end
    @table = association_rows
  end
end

