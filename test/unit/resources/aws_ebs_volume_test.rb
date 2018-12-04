require 'helper'
require 'aws_ebs_volume'
require 'aws-sdk-core'

class AwsEbsVolumeConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEbsVolume.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsEbsVolume.new('rubbish') }
  end

  def test_accepts_volume_id_as_hash_eight_sign
    AwsEbsVolume.new(volume_id: 'vol-1234abcd', client_args: { stub_responses: true })
  end

  def test_accepts_volume_id_as_hash
    AwsEbsVolume.new(volume_id: 'vol-abcd123454321dcba', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsEbsVolume.new(rubbish: 9) }
  end

  def test_rejects_invalid_volume_id
    assert_raises(ArgumentError) { AwsEbsVolume.new(volume_id: 'vol-invalid') }
  end

  def test_volume_non_existing
    refute AwsEbsVolume.new(volume_id: 'vol-1234abcd', client_args: { stub_responses: true }).exists?
  end

  def test_volume_non_existing_name
    refute AwsEbsVolume.new(name: 'not-there', client_args: { stub_responses: true }).exists?
  end
end

class AwsEbsVolumeConstructorNameIdTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_volumes
    mock_volume = {}
    mock_volume[:tags] = [{ :key => 'Name', :value => 'inspec-ebs-volume-name' }]
    mock_volume[:volume_id] = 'vol-079fa6fd624da8e44'
    data[:data] = { :volumes => [mock_volume] }
    data[:client] = Aws::EC2::Client
    @volume = AwsEbsVolume.new(volume_id: 'vol-012b75749d0b5ceb5', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vol_volume_id
    assert_equal(@volume.volume_id, 'vol-079fa6fd624da8e44')
  end

  def test_vol_id
    assert_equal(@volume.id, 'vol-079fa6fd624da8e44')
  end

  def test_vol_exists
    assert @volume.exists?
  end
end

class AwsEbsVolumeHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_volumes
    mock_volume = {}
    mock_volume[:tags] = [{ :key => 'Name', :value => 'inspec-ebs-volume-name' }]
    mock_volume[:availability_zone] = 'eu-west-1a'
    mock_volume[:encrypted] = true
    mock_volume[:size] = 8
    mock_volume[:snapshot_id] = 'snap-66e1ee8b'
    mock_volume[:state] = 'in-use'
    mock_volume[:volume_id] = 'vol-012b75749d0b5ceb5'
    mock_volume[:volume_type] = 'standard'
    mock_volume[:iops] = 100
    data[:data] = { :volumes => [mock_volume] }
    data[:client] = Aws::EC2::Client
    @volume = AwsEbsVolume.new(volume_id: 'vol-012b75749d0b5ceb5', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_volume_exists
    assert @volume.exists?
  end

  def test_volume_availability_zone
    assert_equal(@volume.availability_zone, 'eu-west-1a')
  end

  def test_volume_encrypted
    assert_equal(@volume.encrypted, true)
  end

  def test_volume_size
    assert_equal(@volume.size, 8)
  end

  def test_volume_iops
    assert_equal(@volume.iops, 100)
  end


  def test_volume_snapshot_id
    assert_equal(@volume.snapshot_id, 'snap-66e1ee8b')
  end

  def test_volume_state
    assert_equal(@volume.state, 'in-use')
  end

  def test_vol_volume_id
    assert_equal(@volume.volume_id, 'vol-012b75749d0b5ceb5')
  end

  def test_vol_id
    assert_equal(@volume.id, 'vol-012b75749d0b5ceb5')
  end

  def test_volume_type
    assert_equal(@volume.volume_type, 'standard')
  end
end