require 'helper'
require 'aws_ec2_network_interface_attachment'
require 'aws-sdk-core'

class AWSEC2NetworkInterfaceAttachmentsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_network_interfaces
    mock_data = {}
    mock_data[:subnet_id] = 'test1'
    data[:data] = { :network_interfaces => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2NetworkInterfaces.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_network_interfaces_exists
    assert @resp.exists?
  end

  def test_subnet_ids
    assert_equal(@resp.subnet_ids, ['test1'])
  end
end