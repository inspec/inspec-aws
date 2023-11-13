require "aws_backend"

class AWSEc2VPNGatewayRoutePropagation < AwsResourceBase
  name "aws_ec2_vpn_gateway_route_propagation"
  desc "Describes virtual private gateway (VGW) to propagate routes to the specified route table of a VPC."

  example "
    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'rtb-1234567890') do
      it { should exist }
    end

    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'rtb-1234567890') do
      its ('vpn_gateway_id') { should eq 'vpn_gateway_id }
    end
  "

  def initialize(opts = {})
    opts = { route_table_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:route_table_id])
    raise ArgumentError, "#{@__resource_name__}: route_table_id must be provided" unless opts[:route_table_id] && !opts[:route_table_id].empty?
    @display_name = opts[:route_table_id]
    @route_arguments = { route_table_ids: [opts[:route_table_id]] }
    catch_aws_errors do
      resp = @aws.compute_client.describe_route_tables(@route_arguments)
      @route_tables = resp.route_tables[0].to_h
      create_resource_methods(@route_tables)
    end
  end

  def id
    return unless exists?
    @route_tables[:route_table_id]
  end

  def vpn_gateway_id
    propagating_vgws.map(&:gateway_id)
  end

  def exists?
    !@route_tables.nil? && !@route_tables.empty?
  end

  def resource_id
    @route_tables ? @route_tables[:route_table_id] : @display_name
  end

  def to_s
    "Route Table ID: #{@display_name}"
  end
end
