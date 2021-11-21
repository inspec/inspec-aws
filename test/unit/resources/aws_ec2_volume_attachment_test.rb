require 'helper'
require 'aws_ec2_volume_attachment'
require 'aws-sdk-core'

class AWSEC2VolumeAttachmentConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2VolumeAttachment.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2VolumeAttachment.new(volume_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2VolumeAttachment.new(unexpected: 9) }
  end
end

class AWSEC2VolumeAttachmentSuccessPathTest < Minitest::Test

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
    data[:data] = { volumes: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2VolumeAttachment.new(volume_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_volumes_configs_exists
    assert @resp.exists?
  end

  def test_attach_time
    assert_equal(@resp.attach_time,  Time.parse('2021-09-01 10:55:54 UTC'))
  end

  def test_device
    assert_equal(@resp.device,  'test1')
  end

  def test_instance_id
    assert_equal(@resp.instance_id,  'test1')
  end

  def test_state
    assert_equal(@resp.state,  'test1')
  end

  def test_volume_id
    assert_equal(@resp.volume_id,  'test1')
  end

  def test_delete_on_termination
    assert_equal(@resp.delete_on_termination,  true)
  end
end