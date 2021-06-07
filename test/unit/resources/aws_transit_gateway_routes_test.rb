require 'helper'
require 'aws_transit_gateway_routes'
require 'aws-sdk-core'
require_relative 'mock/aws_transit_gateway_route_mock'

class AwsTransitGatewayRoutesConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsTransitGatewayRoutes.new(client_args: { stub_responses: true }) }
  end

  def test_empty_params_arg_not_ok
    assert_raises(ArgumentError) { AwsTransitGatewayRoutes.new(transit_gateway_route_table_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsTransitGatewayRoutes.new(transit_gateway_route_table_id: 'random-052d947d91b6bb69f') }
  end

  def test_constructor_expected_well_formed_args
    AwsTransitGatewayRoutes.new(transit_gateway_route_table_id: 'tgw-rtb-08acd74550c99e589', longest_prefix_match: '0.0.0.0/0', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsTransitGatewayRoutes.new(random_id: 8) }
  end

  def test_transit_gw_route_non_existing
    refute AwsTransitGatewayRoutes.new(transit_gateway_route_table_id: 'tgw-rtb-08acd74550c99e589', longest_prefix_match: '0.0.0.0/0', client_args: { stub_responses: true }).exists?
  end

  class AwsTransitGatewayRoutesTest < Minitest::Test
    def setup
      @mock = AwsTransitGatewayRouteMock.new
      @transit_gateway_route = AwsTransitGatewayRoutes.new(transit_gateway_route_table_id: @mock.transit_gateway_attachment_id,
                                                           client_args: { stub_responses: true },
                                                           stub_data: [@mock.multiple_stub_data])
    end

    def test_gw_route_cidr_block
      assert_includes(@transit_gateway_route.cidr_blocks, @mock.cidr_block)
    end

    def test_prefix_list_id
      assert_includes(@transit_gateway_route.prefix_list_ids, @mock.prefix_list_id)
    end

    def test_type
      assert_includes(@transit_gateway_route.types, @mock.type)
    end

    def test_state
      assert_includes(@transit_gateway_route.states, @mock.state)
    end
  end
end
