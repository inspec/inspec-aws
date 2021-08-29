require 'helper'
require 'aws_ec2_network_interface_attachment'
require 'aws-sdk-core'

class AWSEC2NetworkInterfaceAttachmentConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2NetworkInterfaceAttachment.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2NetworkInterfaceAttachment.new(network_interface_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2NetworkInterfaceAttachment.new(unexpected: 9) }
  end
end

class AWSEC2NetworkInterfaceAttachmentSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_network_interfaces
    mock_data = {}
    mock_data[:attachment] = {}
    data[:data] = { network_interfaces: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2NetworkInterface.new(network_interface_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end
end