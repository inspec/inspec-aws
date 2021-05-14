require 'helper'
require 'aws_transit_gateway_route'
require 'aws-sdk-core'
require_relative 'mock/aws_transit_gateway_route_mock'

class AwsTransitGatewayRouteConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsTransitGatewayRoute.new(client_args: { stub_responses: true }) }
  end

  def test_empty_params_arg_not_ok
    assert_raises(ArgumentError) { AwsTransitGatewayRoute.new(transit_gateway_route_table_id: '', cidr_block: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsTransitGatewayRoute.new(transit_gateway_route_table_id: 'random-052d947d91b6bb69f', cidr_block: '0.0.0.0/0') }
  end

  def test_constructor_expected_well_formed_args
    AwsTransitGatewayRoute.new(transit_gateway_route_table_id: 'tgw-rtb-08acd74550c99e589', cidr_block: '0.0.0.0/0', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsTransitGatewayRoute.new(random_id: 8) }
  end

  def test_transit_gw_route_non_existing
    refute AwsTransitGatewayRoute.new(transit_gateway_route_table_id: 'tgw-rtb-08acd74550c99e589', cidr_block: '0.0.0.0/0', client_args: { stub_responses: true }).exists?
  end

  class AwsTransitGatewayRouteTest < Minitest::Test
    def setup
      @mock = AwsTransitGatewayRouteMock.new
      @transit_gateway_route = AwsTransitGatewayRoute.new(transit_gateway_route_table_id: @mock.transit_gateway_attachment_id,
                                                          cidr_block: @mock.cidr_block,
                                                          client_args: { stub_responses: true },
                                                          stub_data: [@mock.stub_data])
    end

    def test_gw_route_cidr_block
      assert_equal(@transit_gateway_route.cidr_block, @mock.cidr_block)
    end

    def test_prefix_list_id
      assert_equal(@transit_gateway_route.prefix_list_id, @mock.prefix_list_id)
    end

    def test_type
      assert_equal(@transit_gateway_route.type, @mock.type)
    end

    def test_state
      assert_equal(@transit_gateway_route.state, @mock.state)
    end
  end
end
