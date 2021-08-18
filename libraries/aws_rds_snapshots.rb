# frozen_string_literal: true

require 'aws_backend'

class AwsRdsSnapshots < AwsResourceBase
  name 'aws_rds_snapshots'
  desc 'Verifies settings for AWS RDS snapshots in bulk'
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

  attr_reader :table

  FilterTable.create
             .register_column(:db_snapshot_identifiers, field: :db_snapshot_identifier)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    rds_snapshot_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.rds_client.describe_db_snapshots(**pagination_options)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.db_snapshots.each do |db_snapshot|
        rds_snapshot_rows += [{ db_snapshot_identifier: db_snapshot.db_snapshot_identifier }]
      end
      break unless @api_response.marker
      pagination_options = { marker: @api_response[:marker] }
    end
    @table = rds_snapshot_rows
  end
end
