require 'helper'
require 'aws_ebs_snapshots'
require 'aws-sdk-core'

class AwsEbsSnaphotsConstructorTest < Minitest::Test
  def test_empty_params_ok
    AwsEbsSnapshots.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsEbsSnapshots.new('rubbish') }
  end

  def test_snapshots_non_existing_for_empty_response
    refute AwsEbsSnapshots.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsEbsSnaphotsHappyPathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_snapshots
    mock_snapshot = {}
    mock_snapshot[:tags] = [{ :key => 'Name', :value => 'inspec-ebs-snapshot-name' }]
    mock_snapshot[:progress] = '100%'
    mock_snapshot[:encrypted] = true
    mock_snapshot[:snapshot_id] = 'snap-0e6c89e2aca6e66fb'
    mock_snapshot[:state] = 'completed'
    mock_snapshot[:volume_id] = 'vol-012b75749d0b5ceb5'
    data[:data] = { :snapshots => [mock_snapshot] }
    data[:client] = Aws::EC2::Client
    @snapshot = AwsEbsSnapshot.new(snapshot_id: 'snap-0e6c89e2aca6e66fb', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_snapshots_exists
    assert @snapshot.exist?
  end

  def test_snapshots_ids
    assert_equal('snap-0e6c89e2aca6e66fb', @snapshot.snapshot_id)
  end

  def test_snapshots_filtering_there
    assert @snapshot.where(:snapshot_id => 'snap-0e6c89e2aca6e66fb').exist?
  end
end
