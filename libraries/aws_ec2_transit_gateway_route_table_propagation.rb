require "aws_backend"

class AWSEc2TransitGatewayRouteTablePropagation < AwsResourceBase
  name "aws_ec2_transit_gateway_route_table_propagation"
  desc "Describes information about the route table propagations for the specified transit gateway route table."
  example "
    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'test1') do
      it { should exist }
    end
    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'test1') do
      its ('state') { should eq 'enabled }
    end
  "

  def initialize(opts = {})
    opts = { transit_gateway_route_table_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(transit_gateway_route_table_id transit_gateway_attachment_id))
    raise ArgumentError, "#{@__resource_name__}: transit_gateway_route_table_id must be provided" unless opts[:transit_gateway_route_table_id] && !opts[:transit_gateway_route_table_id].empty?
    raise ArgumentError, "#{@__resource_name__}: transit_gateway_attachment_id must be provided" unless opts[:transit_gateway_attachment_id] && !opts[:transit_gateway_attachment_id].empty?
    @display_name = opts[:transit_gateway_attachment_id]
    filter = [
      {
        name: "transit-gateway-attachment-id",
        values: [opts[:transit_gateway_attachment_id]],
      },
    ]
    catch_aws_errors do
      resp = @aws.compute_client.get_transit_gateway_route_table_propagations({ transit_gateway_route_table_id: opts[:transit_gateway_route_table_id],
                                                                                filters: filter })
      @resp = resp.transit_gateway_route_table_propagations[0].to_h
      create_resource_methods(@resp)
    end
  end

  def resource_id
    @resp ? @resp[:resource_id] : @display_name
  end

  def transit_gateway_attachment_id
    return unless exists?
    @resp[:transit_gateway_attachment_id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "Transit Gateway Attachment ID: #{@display_name}"
  end
end
