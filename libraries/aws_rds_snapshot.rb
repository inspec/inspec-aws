# frozen_string_literal: true

require 'aws_backend'

class AwsRdsSnapshot < AwsResourceBase
  name 'aws_rds_snapshot'
  desc 'Verifies settings for an RDS snapshot'

  example "
    describe aws_rds_snapshot(db_snapshot_identifier: 'test-snapshot-id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { db_snapshot_identifier: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:db_snapshot_identifier])

    raise ArgumentError, "#{@__resource_name__}: db_snapshot_identifier must start with a letter followed by up to 1 to 255 characters." if opts[:db_snapshot_identifier] !~ /^[a-z]{1}[0-9a-z\-\:]{1,255}$/

    catch_aws_errors do
      @display_name = opts[:db_snapshot_identifier]

      resp = @aws.rds_client.describe_db_snapshots(db_snapshot_identifier: opts[:db_snapshot_identifier])
      return if resp.db_snapshots.empty?
      @rds_snapshot = resp.db_snapshots[0].to_h
      create_resource_methods(@rds_snapshot)
    end
  end

  def has_encrypted_snapshot?
    @rds_snapshot[:encrypted]
  end
  alias encrypted? has_encrypted_snapshot?

  def exists?
    !@rds_snapshot.nil? && !@rds_snapshot.empty?
  end

  def to_s
    "RDS Snapshot #{@display_name}"
  end
end
