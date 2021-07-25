require 'helper'
require 'aws_ec2_vpn_connection_routes'
require 'aws-sdk-core'

class AWSEc2VPNConnectionRoutesConstructorTest < Minitest::Test

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEc2VPNConnectionRoutes.new('rubbish') }
  end
end

class AWSEc2VPNConnectionRoutesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_vpn_connections
    mock_data = {}
    mock_data[:routes] = []
    data[:data] = { :vpn_connections => [mock_data] }
    data[:client] = Aws::EC2::Client
    @vpn_connections = AWSEc2VPNConnectionRoutes.new(vpn_connection_id: 'vpn-123456790123456', client_args: { stub_responses: true }, stub_data: [data])
  end
end