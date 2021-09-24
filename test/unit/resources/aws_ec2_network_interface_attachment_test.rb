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
    mock_data[:attachment] = {
      attachment_id: "test1",
      delete_on_termination: true,
      device_index: 1,
      network_card_index:1,
      instance_id: "test1",
      instance_owner_id: "1234567890",
      status: "attached"
    }
    data[:data] = { network_interfaces: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2NetworkInterfaceAttachment.new(network_interface_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_network_interfaces_exists
    assert @resp.exists?
  end

  def test_attachment_id
    assert_equal(@resp.attachment_id,  'test1')
  end

  def test_delete_on_termination
    assert_equal(@resp.delete_on_termination,  true)
  end

  def test_device_index
    assert_equal(@resp.device_index,  1)
  end

  def test_network_card_index
    assert_equal(@resp.network_card_index,  1)
  end

  def test_instance_id
    assert_equal(@resp.instance_id,  'test1')
  end

  def test_instance_owner_id
    assert_equal(@resp.instance_owner_id,  '1234567890')
  end

  def test_status
    assert_equal(@resp.status,  'attached')
  end
end