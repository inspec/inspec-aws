require_relative 'aws_base_resource_mock'

class AwsTransitGatewayRouteMock < AwsBaseResourceMock
  attr_reader :transit_gateway_attachment_id, :vpc_id, :cidr_block, :prefix_list_id, :type, :state

  def initialize
    super
    @cidr_block = '0.0.0.0/0'
    @vpc_id = 'vpc-08b86815ee2c22d53'
    @transit_gateway_attachment_id = 'tgw-rtb-08acd74550c99e589'
    @type = 'propagated'
    @state = 'active'
    @prefix_list_id = 'pl-4ca54025'
    @transit_gateway_attachment = {
      transit_gateway_attachment_id: @transit_gateway_attachment_id,
      resource_id: @vpc_id,
      resource_type: 'vpc',
    }
    @route = {
      destination_cidr_block: @cidr_block,
      prefix_list_id: @prefix_list_id,
      transit_gateway_attachments: [@transit_gateway_attachment],
      type: @type,
      state: @state,
    }
    @transit_gateway_route = {
      routes: [
        @route,
      ],
      additional_routes_available: false,
    }
  end

  def stub_data
    {
      method: :search_transit_gateway_routes,
      client: Aws::EC2::Client,
      data: @transit_gateway_route,
    }
  end

  def multiple_stub_data(num = 2)
    route_collection(num)
    {
      method: :search_transit_gateway_routes,
      client: Aws::EC2::Client,
      data: @transit_gateway_route,
    }
  end

  def route_collection(num)
    @route_collection ||= num.times { @transit_gateway_route[:routes] << @route }
  end
end
