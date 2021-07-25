require 'helper'
require 'aws_ec2_volume_attachment'
require 'aws-sdk-core'

class AWSEc2VolumeAttachmentConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEc2VolumeAttachment.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEc2VolumeAttachment.new(volume_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEc2VolumeAttachment.new(unexpected: 9) }
  end
end

class AWSEc2VolumeAttachmentSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_volumes
    mock_data = {}
    mock_data[:volume_id] = "vol-012b75749d0b5ceb5"
    mock_data[:attachments] = []
    data[:data] = { :volumes => [mock_data] }
    data[:client] = Aws::EC2::Client
    @vol = AWSEc2VolumeAttachment.new(volume_id: 'vol-012b75749d0b5ceb5', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_volume_id_exists
    assert @vol.exists
  end

  def test_volume_id
    assert_nil(@vol.volume_id, nil)
  end
end