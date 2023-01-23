require 'helper'
require 'aws_ec2_volume_attachments'
require 'aws-sdk-core'

class AWSEC2VolumeAttachmentsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2VolumeAttachments.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2VolumeAttachments.new('rubbish') }
  end

  def test_volume_attachments_configs_non_existing_for_empty_response
    refute AWSEC2VolumeAttachments.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2VolumeAttachmentsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_volumes
    mock_data = {}
    mock_data[:attachments] = [{
                                 attach_time: Time.parse('2021-09-01 10:55:54 UTC'),
                                 device: 'test1',
                                 instance_id: 'test1',
                                 state: "test1",
                                 volume_id: "test1",
                                 delete_on_termination: true
                               }]
    data[:data] = { :volumes => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2VolumeAttachments.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_devices
    assert_equal(@resp.devices,  [['test1']])
  end

  def test_instance_ids
    assert_equal(@resp.instance_ids,  [['test1']])
  end

  def test_states
    assert_equal(@resp.states,  [['test1']])
  end

  def test_volume_ids
    assert_equal(@resp.volume_ids,  [['test1']])
  end

  def test_delete_on_terminations
    assert_equal(@resp.delete_on_terminations,  [[true]])
  end
end