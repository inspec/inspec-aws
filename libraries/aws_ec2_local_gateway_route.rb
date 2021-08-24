# frozen_string_literal: true

require 'aws_backend'

class AWSEC2LocalGatewayRoute < AwsResourceBase
  name 'aws_ec2_local_gateway_route'
  desc 'Test the singular local gateway route.'

  example "
    describe aws_ec2_local_gateway_route(local_gateway_route_table_id: 'LocalGatewayRoutetableId') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { local_gateway_route_table_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:local_gateway_route_table_id])
    raise ArgumentError, "#{@__resource_name__}: local_gateway_route_table_id must be provided" unless opts[:local_gateway_route_table_id] && !opts[:local_gateway_route_table_id].empty?
    @display_name = opts[:local_gateway_route_table_id]
    filter = { name: 'local-gateway-route-table-id', values: [opts[:local_gateway_route_table_id]] }
    catch_aws_errors do
      resp = @aws.compute_client.search_local_gateway_routes({ local_gateway_route_table_id: opts[:local_gateway_route_table_id], filters: [filter] })
      @res = resp.routes[0].to_h
      create_resource_methods(@res)
    end
  end

  def local_gateway_route_table_id
    return nil unless exists?
    @res[:local_gateway_route_table_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Local Gateway Route Table ID: #{@display_name}"
  end
end
