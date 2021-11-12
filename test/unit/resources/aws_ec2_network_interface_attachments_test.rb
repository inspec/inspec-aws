require 'helper'
require 'aws_ec2_network_interface_attachments'
require 'aws-sdk-core'

class AWSEC2NetworkInterfaceAttachmentsHappyPathTest < Minitest::Test

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
    data[:data] = { :network_interfaces => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2NetworkInterfaceAttachments.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_attachment_ids
    assert_equal(@resp.attachment_ids,  ['test1'])
  end

  def test_delete_on_terminations
    assert_equal(@resp.delete_on_terminations,  [true])
  end

  def test_device_indexes
    assert_equal(@resp.device_indexes,  [1])
  end

  def test_network_card_indexes
    assert_equal(@resp.network_card_indexes,  [1])
  end

  def test_instance_ids
    assert_equal(@resp.instance_ids,  ['test1'])
  end

  def test_instance_owner_ids
    assert_equal(@resp.instance_owner_ids,  ['1234567890'])
  end

  def test_statuses
    assert_equal(@resp.statuses,  ['attached'])
  end
end