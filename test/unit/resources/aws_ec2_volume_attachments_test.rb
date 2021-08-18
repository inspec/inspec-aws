require 'helper'
require 'aws_ec2_volume_attachments'
require 'aws-sdk-core'

class AWSEc2VolumeAttachmentsConstructorTest < Minitest::Test
  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEc2VolumeAttachments.new('rubbish') }
  end
end

class AWSEc2VolumeAttachmentsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_volumes
    mock_data = {}
    data[:data] = { :volumes => [mock_data] }
    data[:client] = Aws::EC2::Client
    @vol = AWSEc2VolumeAttachments.new(volume_id: 'vol-012b75749d0b5ceb5', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_volume_id_exists
    assert @vol.exists
  end
end