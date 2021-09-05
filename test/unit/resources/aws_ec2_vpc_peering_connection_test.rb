require 'helper'
require 'aws_ec2_vpc_peering_connection'
require 'aws-sdk-core'

class AWSEC2VPCPeeringConnectionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2VPCPeeringConnection.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2VPCPeeringConnection.new(vpc_peering_connection_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2VPCPeeringConnection.new(unexpected: 9) }
  end
end

class AWSEC2VPCPeeringConnectionSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_vpc_peering_connections
    mock_data = {}
    mock_data[:vpc_peering_connection_id] = "test1"
    mock_data[:status] = {
      code: "test1",
      message: "test1"
    }
    data[:data] = { vpc_peering_connections: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2VPCPeeringConnection.new(vpc_peering_connection_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpc_peering_connections_exists
    assert @resp.exists?
  end

  def test_vpc_peering_connection_id
    assert_equal(@resp.vpc_peering_connection_id, "test1")
  end

  def test_status_code
    assert_equal(@resp.status.code, "test1")
  end

  def test_status_message
    assert_equal(@resp.status.message, "test1")
  end
end