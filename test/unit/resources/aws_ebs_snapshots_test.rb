require 'helper'
require 'aws_ebs_snapshots'
require 'aws-sdk-core'
require_relative 'mock/aws_ebs_snapshot_mock'

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
    mock = AwsEbsSnapshotMock.new
    @mock_snapshots = []
    @mock_snapshots += [mock.snapshot_public]
    @mock_snapshots += [mock.snapshot_private]

    stub_data = [{:client => Aws::EC2::Client,
      :method => :describe_snapshots,
      :data =>  {snapshots: @mock_snapshots}}]

    @snapshots = AwsEbsSnapshots.new(client_args: { stub_responses: true }, stub_data: stub_data)
  end

  def test_snapshots_exists
    assert @snapshots.exist?
  end

  def test_snapshots_ids
    assert_equal(@snapshots.snapshot_ids, ['snap-0e5c89e1eca7e66fa', 'snap-0e5c89e1eca7e66fb'])
  end

  def test_snapshots_filtering_there
    assert @snapshots.where(:snapshot_id => 'snap-0e5c89e1eca7e66fa').exist?
  end

  def test_snapshots_filtering_not_there
    refute @snapshots.where(:snapshot_id => 'bad').exist?
  end
end
