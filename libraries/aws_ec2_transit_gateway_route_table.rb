require 'aws_backend'

class AwsEc2TransitGatewayRouteTable < AwsResourceBase
  name 'aws_ec2_transit_gateway_route_table'
  desc 'Describes one or more transit gateway route tables. By default, all transit gateway route tables are described. Alternatively, you can filter the results.'

  example "
    describe aws_ec2_transit_gateway_route_table(transit_gateway_route_table_id: 'tgw-rtb-0123456789') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { transit_gateway_route_table_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:transit_gateway_route_table_id])
    raise ArgumentError, "#{@__resource_name__}: transit_gateway_route_table_id must be provided" unless opts[:transit_gateway_route_table_id] && !opts[:transit_gateway_route_table_id].empty?
    @display_name = opts[:transit_gateway_route_table_id]
    catch_aws_errors do
      resp = @aws.compute_client.describe_transit_gateway_route_tables({ transit_gateway_route_table_ids: [opts[:transit_gateway_route_table_id]] })
      @transit_gateway_route_tables = resp.transit_gateway_route_tables[0].to_h
      create_resource_methods(@transit_gateway_route_tables)
    end
  end

  def transit_gateway_route_table_id
    return nil unless exists?
    @transit_gateway_route_tables[:transit_gateway_route_table_id]
  end

  def exists?
    !@transit_gateway_route_tables.nil? && !@transit_gateway_route_tables.empty?
  end

  def resource_id
    @transit_gateway_route_tables ? @transit_gateway_route_tables[:transit_gateway_route_table_id] : @display_name
  end

  def to_s
    "Transit gateway route table #{@display_name}"
  end
end
