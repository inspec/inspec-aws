require 'helper'
require 'aws_ec2_client_vpn_route'
require 'aws-sdk-core'

class AWSEC2ClientVPNRouteConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2ClientVPNRoute.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_client_vpn_endpoint_id_as_hash_eight_sign
    AWSEC2ClientVPNRoute.new(client_vpn_endpoint_id: 'test', target_subnet: 'test', client_args: { stub_responses: true })
  end

  def test_accepts_client_vpn_endpoint_id_as_hash
    AWSEC2ClientVPNRoute.new(client_vpn_endpoint_id: 'test', target_subnet: 'test', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2ClientVPNRoute.new(rubbish: 9) }
  end
end

class AWSEC2ClientVPNRoutePathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_client_vpn_routes
    mock_data = {}
    mock_data[:client_vpn_endpoint_id] = "test"
    mock_data[:description] = 'test'
    mock_data[:target_subnet] = 'test'
    mock_data[:destination_cidr] = 'test'
    mock_data[:type] = 'vpc'
    mock_data[:origin] = 'test'
    mock_data[:status] = { code: "test", message: "test" }
    data[:data] = { routes: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2ClientVPNRoute.new(client_vpn_endpoint_id: 'test', target_subnet: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_routes_exists
    assert @resp.exists?
  end

  def test_routes_available
    assert @resp.available?
  end

  def test_client_vpn_endpoint_id
    assert_equal(@resp.client_vpn_endpoint_id, 'test')
  end

  def test_description
    assert_equal(@resp.description, 'test')
  end

  def test_destination_cidr
    assert_equal(@resp.destination_cidr, 'test')
  end

  def test_code
    assert_equal(@resp.status.code, 'test')
  end
end