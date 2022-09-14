aws_rds_snapshot_identifier = input(:aws_rds_snapshot_identifier, value: '', description: 'The AWS RDS snapshot identifier.')

title 'Test multiple AWS RDS snapshots'

control 'aws-rds-snapshots-1.0' do
  impact 1.0
  title 'Ensure AWS RDS Snapshots has the correct properties.'

  describe aws_rds_snapshots do
    it { should exist }
  end

  aws_rds_snapshots.where(db_snapshot_identifier: aws_rds_snapshot_identifier).db_snapshot_identifiers.each do |db_snapshot_identifier|
    describe aws_rds_snapshot(db_snapshot_identifier) do
      it { should have_encrypted_snapshot }
      it { should be_encrypted }
    end
  end

  aws_rds_snapshots.entries.each do |entry|
    describe aws_rds_snapshot(resource_data: entry) do
      it { should exist }
    end
  end
end
