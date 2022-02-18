require 'helper'
require 'aws_ebs_volumes'
require 'aws-sdk-core'

class AwsEbsVolumesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsEbsVolumes.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsEbsVolumes.new('rubbish') }
  end

  def test_volumes_non_existing_for_empty_response
    refute AwsEbsVolumes.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsEbsVolumesHappyPathTest < Minitest::Test

  def setup
    attachment_state = %w(attaching attached detaching)
    encrypted = [true, false]
    volume_id = "ebs-12345"
    delete_on_termination = [true, false]
    state = %w(creating available in-use deleting deleted error)
    volume_type = %w(standard io1 io2 gp2 sc1 st1)
    fast_restore = [true, false]
    multi_attach = [true, false]
    data = {}
    data[:method] = :describe_volumes
    @mock_volume = {}
    @mock_volume[:volume_id] = 'vol-012b75749d0b5ceb5'
    @mock_volume[:availability_zone] = 'us-east1a'
    @mock_volume[:create_time] = Time.now.round(0)
    @mock_volume[:encrypted] = encrypted.sample
    @mock_volume[:kms_key_id] = 'keyid'
    @mock_volume[:outpost_arn] = 'arn'
    @mock_volume[:size] = 10
    @mock_volume[:snapshot_id] = "snap-123456"
    @mock_volume[:state] = state.sample
    @mock_volume[:iops] = 100
    @mock_volume[:tags] = [{ :key => 'keykey', :value => 'valuevalue' }]
    @mock_volume[:volume_type] = volume_type.sample
    @mock_volume[:fast_restored] = fast_restore.sample
    @mock_volume[:multi_attach_enabled] = multi_attach.sample
    @mock_volume[:attachments] = [{ :attach_time => Time.now, :device => 'devicename', :instance_id => 'instanceid', :state => attachment_state.sample, :volume_id => volume_id, :delete_on_termination => delete_on_termination.sample }]
    data[:data] = { :volumes => [@mock_volume] }
    data[:client] = Aws::EC2::Client
    @volumes = AwsEbsVolumes.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_volumes_exists
    assert @volumes.exist?
  end

  def test_volumes_ids
    assert_equal(@volumes.volume_ids, [@mock_volume[:volume_id]])
  end

  def test_attachments
    assert_equal(@volumes.attachments[0][0].state, @mock_volume[:attachments][0][:state])
  end

  def test_availability_zones
    assert_equal(@volumes.availability_zones, [@mock_volume[:availability_zone]])
  end

  def test_create_time
    assert_equal(@volumes.create_times, [@mock_volume[:create_time]])
  end

  def test_encrypted
    assert_equal(@volumes.encrypted, [@mock_volume[:encrypted]])
  end

  def test_kms_key_id
    assert_equal(@volumes.kms_key_ids, [@mock_volume[:kms_key_id]])
  end

  def test_outpost_arn
    assert_equal(@volumes.outpost_arns, [@mock_volume[:outpost_arn]])
  end

  def test_size
    assert_equal(@volumes.sizes, [@mock_volume[:size]])
  end

  def test_multi_attach_enabled
    assert_equal(@volumes.multi_attach_enabled, [@mock_volume[:multi_attach_enabled]])
  end

  def test_fast_restored
    assert_equal(@volumes.fast_restored, [@mock_volume[:fast_restored]])
  end

  def test_fast_restored
    assert_equal(@volumes.volume_types, [@mock_volume[:volume_type]])
  end

  def test_tags
    assert_equal(@volumes.tags[0][0].key, @mock_volume[:tags][0][:key])
    assert_equal(@volumes.tags[0][0].value, @mock_volume[:tags][0][:value])
  end

  def test_iops
    assert_equal(@volumes.iops, [@mock_volume[:iops]])
  end

  def test_state
    assert_equal(@volumes.states, [@mock_volume[:state]])
  end

  def test_snapshot_id
    assert_equal(@volumes.snapshot_ids, [@mock_volume[:snapshot_id]])
  end

  def test_volumes_filtering_not_there
    refute @volumes.where(:volume_id => 'bad').exist?
  end

  def test_volumes_filtering_there
    assert @volumes.where(:volume_id => 'vol-012b75749d0b5ceb5').exist?
  end
end