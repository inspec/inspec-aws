require 'aws_backend'

class AwsEc2TransitGatewayRouteTableAssociation < AwsResourceBase
  name 'aws_ec2_transit_gateway_route_table_association'
  desc 'Gets information about the associations for the specified transit gateway route table.'

  example "
    describe aws_ec2_transit_gateway_route_table_association(transit_gateway_route_table_id: 'tgw-attach-0123456789') do
      it { should exist }
    end
  "

  attr_reader :table

  def initialize(opts = {})
    opts = { transit_gateway_route_table_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:transit_gateway_route_table_id])
    raise ArgumentError, "#{@__resource_name__}: transit_gateway_route_table_id must be provided" unless opts[:transit_gateway_route_table_id] && !opts[:transit_gateway_route_table_id].empty?
    @display_name = opts[:transit_gateway_route_table_id]
    catch_aws_errors do
      resp = aws.compute_client.get_transit_gateway_route_table_associations({ transit_gateway_route_table_id: @display_name })
      @association = resp.associations[0].to_h
      create_resource_methods(@association)
    end
  end

  def resource_id
    @association ? @association[:resource_id] : @display_name
  end

  def transit_gateway_route_table_id
    return nil unless exists?
    @association[:transit_gateway_route_table_id]
  end

  def exists?
    !@association.nil? && !@association.empty?
  end

  def to_s
    "Transit gateway Route table Association: #{@display_name}"
  end
end
