require_relative 'aws_base_resource_mock'

class AwsEbsSnapshotMock < AwsBaseResourceMock

  def initialize
    super
    mock_snapshot = {
      progress: '100%',
      encrypted: true,
      state: 'completed'
    }

    @mock_snapshot_public = mock_snapshot.dup
    @mock_snapshot_public[:tags] = [{ :key => 'Name', :value => 'public-snapshot' }]
    @mock_snapshot_public[:snapshot_id] = 'snap-0e5c89e1eca7e66fa'
    @mock_snapshot_public[:volume_id] = 'vol-012b75749d0b5ceb5'

    @mock_snapshot_attributes_public = {}
    @mock_snapshot_attributes_public[:create_volume_permissions] = [{ :group => 'all' }]
    @mock_snapshot_attributes_public[:snapshot_id] = 'snap-0e6c89e2aca6e66fb'
    @mock_snapshot_attributes_public[:product_codes] = []

    @mock_snapshot_private = mock_snapshot.dup
    @mock_snapshot_private[:tags] = [{ :key => 'Name', :value => 'private-snapshot' }]
    @mock_snapshot_private[:snapshot_id] = 'snap-0e5c89e1eca7e66fb'
    @mock_snapshot_private[:volume_id] = 'vol-012b75749d0b5ceb6'

    @mock_snapshot_attributes_private = {}
    @mock_snapshot_attributes_private[:create_volume_permissions] = []
    @mock_snapshot_attributes_private[:snapshot_id] = 'snap-0e6c89e2aca6e66fb'
    @mock_snapshot_attributes_private[:product_codes] = []
  end

  def stub_data_public
    stub_data(@mock_snapshot_public, @mock_snapshot_attributes_public)
  end

  def stub_data_private
    stub_data(@mock_snapshot_private, @mock_snapshot_attributes_private)
  end

  def stub_data(mock_snapshot, mock_snapshot_attributes)
    stub_data = []
    describe_snapshots = {
      :client => Aws::EC2::Client,
      :method => :describe_snapshots,
      :data => { :snapshots => [mock_snapshot] }
    }
    stub_data += [describe_snapshots]

    describe_snapshot_attribute = {
      :client => Aws::EC2::Client,
      :method => :describe_snapshot_attribute,
      :data => mock_snapshot_attributes
    }
    stub_data += [describe_snapshot_attribute]
  end

  def snapshot_public
    @mock_snapshot_public
  end

  def snapshot_private
    @mock_snapshot_private
  end
end
