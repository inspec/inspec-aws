require "aws_backend"

class AwsRdsSnapshots < AwsCollectionResourceBase
  name "aws_rds_snapshots"
  desc "Verifies settings for AWS RDS snapshots in bulk."
  example "
    describe aws_rds_snapshots do
      it { should exist }
    end

    describe aws_rds_snapshots do
      its('entries.count') { should be > 1 }
    end

    # Iterate through all snapshots
    aws_rds_snapshots.db_snapshot_identifiers.each do |db_snapshot_identifier|
      describe aws_rds_snapshot(db_snapshot_identifier) do
        it { should have_encrypted_snapshot }
        it { should be_encrypted }
      end
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch(client: :rds_client, operation: :describe_db_snapshots).db_snapshots.map(&:to_h)

    populate_filter_table_from_response
  end
end
