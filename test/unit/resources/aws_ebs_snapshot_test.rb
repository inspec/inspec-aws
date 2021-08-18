require 'helper'
require 'aws_ebs_snapshot'
require 'aws-sdk-core'
require_relative 'mock/aws_ebs_snapshot_mock'

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

class AwsEbsSnapshotPublicPathTest < Minitest::Test
  def setup
    @snapshot = AwsEbsSnapshot.new(
      snapshot_id: 'snap-0e5c89e1eca7e66fa',
      client_args: { stub_responses: true },
      stub_data: AwsEbsSnapshotMock.new.stub_data_public
    )
  end

  def test_snapshot_id
    assert_equal(@snapshot.snapshot_id, 'snap-0e5c89e1eca7e66fa')
  end

  def test_snapshot_group
    assert_equal(@snapshot.group, 'all')
  end

  def test_snapshot_public
    assert @snapshot.public?
  end

  def test_snapshot_public
    refute @snapshot.private?
  end

  def test_snapshot_encrypted
    assert @snapshot.encrypted?
  end

  def test_snapshot_exists
    assert @snapshot.exist?
  end
end

class AwsEbsSnapshotPrivatePathTest < Minitest::Test
  def setup
    @snapshot = AwsEbsSnapshot.new(
      snapshot_id: 'snap-0e5c89e1eca7e66fa',
      client_args: { stub_responses: true },
      stub_data: AwsEbsSnapshotMock.new.stub_data_private
    )
  end

  def test_snapshot_private
    assert @snapshot.private?
  end

  def test_snapshot_group
    assert_nil(@group)
  end
end
