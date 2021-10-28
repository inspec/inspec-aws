require 'helper'
require 'aws_ec2_client_vpn_routes'
require 'aws-sdk-core'

class AWSEC2ClientVPNRoutesConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2ClientVPNRoutes.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_client_vpn_endpoint_id_as_hash_eight_sign
    AWSEC2ClientVPNRoutes.new(client_vpn_endpoint_id: 'test', client_args: { stub_responses: true })
  end

  def test_accepts_client_vpn_endpoint_id_as_hash
    AWSEC2ClientVPNRoutes.new(client_vpn_endpoint_id: 'test', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2ClientVPNRoutes.new(rubbish: 9) }
  end
end

class AWSEC2ClientVPNRoutessPathTest < Minitest::Test
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
    @resp = AWSEC2ClientVPNRoutes.new(client_vpn_endpoint_id: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_routes_exists
    assert @resp.exists?
  end

  def test_routes_available
    assert @resp.available?
  end

  def test_client_vpn_endpoint_ids
    assert_equal(@resp.client_vpn_endpoint_ids, ['test'])
  end

  def test_descriptions
    assert_equal(@resp.descriptions, ['test'])
  end

  def test_destination_cidr
    assert_equal(@resp.destination_cidr, ['test'])
  end

  def test_codes
    assert_equal(@resp.status_codes, ['test'])
  end
end