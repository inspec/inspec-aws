require 'helper'
require 'aws_ebs_snapshot'
require 'aws-sdk-core'

class AwsEbsSnapshotConstructorTest < Minitest::Test
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsEbsSnapshot.new(client_args: { stub_responses: true }) }
  end

  def test_rejects_scalar_invalid_args
    assert_raises(ArgumentError) { AwsEbsSnapshot.new('rubbish') }
  end

  def test_accepts_snapshot_id_as_hash_eight_sign
    AwsEbsSnapshot.new(snapshot_id: 'snap-1234abcd', client_args: { stub_responses: true })
  end

  def test_accepts_snapshot_id_as_hash
    AwsEbsSnapshot.new(snapshot_id: 'snap-abcd123454321dcba', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsEbsSnapshot.new(rubbish: 9) }
  end

  def test_rejects_invalid_snapshot_id
    assert_raises(ArgumentError) { AwsEbsSnapshot.new(snapshot_id: 'snap-invalid') }
  end

  def test_snapshot_non_existing
    refute AwsEbsSnapshot.new(snapshot_id: 'snap-1234abcd', client_args: { stub_responses: true }).exists?
  end

  def test_snapshot_non_existing_name
    refute AwsEbsSnapshot.new(name: 'not-there', client_args: { stub_responses: true }).exists?
  end
end

class AwsEbsSnapshotConstructorNameIdTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_snapshots
    mock_snapshot = {}
    mock_snapshot[:tags] = [{ :key => 'Name', :value => 'inspec-ebs-snapshot-name' }]
    mock_snapshot[:progress] = '100%'
    mock_snapshot[:encrypted] = true
    mock_snapshot[:snapshot_id] = 'snap-0e5c89e1eca7e66fa'
    mock_snapshot[:state] = 'completed'
    mock_snapshot[:volume_id] = 'vol-012b75749d0b5ceb5'
    data[:data] = { :snapshots => [mock_snapshot] }
    data[:client] = Aws::EC2::Client
    @snapshot = AwsEbsSnapshot.new(snapshot_id: 'snap-0e5c89e1eca7e66fa', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_snap_snapshot_id
    assert_equal('snap-0e5c89e1eca7e66fa', @snapshot.snapshot_id)
  end

  def test_snap_exists
    assert @snapshot.exists?
  end
end

class AwsEbsSnapshotHappyPathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_snapshots
    mock_snapshot = {}
    mock_snapshot[:tags] = [{ :key => 'Name', :value => 'inspec-ebs-snapshot-name' }]
    mock_snapshot[:progress] = '100%'
    mock_snapshot[:encrypted] = true
    mock_snapshot[:snapshot_id] = 'snap-0e5c89e1eca7e66fa'
    mock_snapshot[:state] = 'completed'
    mock_snapshot[:volume_id] = 'vol-012b75749d0b5ceb5'
    data[:data] = { :snapshots => [mock_snapshot] }
    data[:client] = Aws::EC2::Client
    @snapshot = AwsEbsSnapshot.new(snapshot_id: 'snap-0e5c89e1eca7e66fa', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_volume_exists
    assert @snapshot.exists?
  end

  def test_snapshot_encrypted
    assert @snapshot.encrypted?
  end

  def test_snapshot_state
    assert_equal('completed', @snapshot.state)
  end

  def test_snapshot_volume_id
    assert_equal('vol-012b75749d0b5ceb5', @snapshot.volume_id)
  end

  def test_snapshot_id
    assert_equal('snap-0e5c89e1eca7e66fa', @snapshot.snapshot_id)
  end
end

class AwsEbsSnapshotPublicPathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_snapshot_attribute
    mock_snapshot_attributes = {}
    mock_snapshot_attributes[:create_volume_permissions] = [{ :group => 'all' }]
    mock_snapshot_attributes[:product_codes] = []
    mock_snapshot_attributes[:snapshot_id] = 'snap-0e6c89e2aca6e66fb'
    data[:data] = mock_snapshot_attributes
    data[:client] = Aws::EC2::Client
    @snapshot = AwsEbsSnapshot.new(snapshot_id: 'snap-0e6c89e2aca6e66fb', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_snapshot_public
    assert @snapshot.public?
  end
end

class AwsEbsSnapshotPrivatePathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_snapshot_attribute
    mock_snapshot_attributes = {}
    mock_snapshot_attributes[:create_volume_permissions] = []
    mock_snapshot_attributes[:product_codes] = []
    mock_snapshot_attributes[:snapshot_id] = 'snap-0e6c89e2aca6e66fb'
    data[:data] = mock_snapshot_attributes
    data[:client] = Aws::EC2::Client
    @snapshot_attributes = AwsEbsSnapshot.new(snapshot_id: 'snap-0e6c89e2aca6e66fb', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_snapshot_private
    assert @snapshot_attributes.private?
  end
end
