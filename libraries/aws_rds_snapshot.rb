require 'aws_backend'

class AwsRdsSnapshot < AwsResourceBase
  name 'aws_rds_snapshot'
  desc 'Verifies settings for an RDS snapshot.'

  example "
    describe aws_rds_snapshot(db_snapshot_identifier: 'test-snapshot-id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { db_snapshot_identifier: opts } if opts.is_a?(String)
    super(opts)
    unless @resource_data
      validate_parameters(required: [:db_snapshot_identifier])
      raise ArgumentError, "#{@__resource_name__}: db_snapshot_identifier must start with a letter followed by up to 1 to 255 characters." if opts[:db_snapshot_identifier] !~ /^[a-z]{1}[0-9a-z\-\:]{1,255}$/
    end
    @display_name = opts[:db_snapshot_identifier] || opts.dig(@resource_data, :db_snapshot_identifier)
    @rds_snapshot = @resource_data || get_resource(opts)
    create_resource_methods(@rds_snapshot)
  end

  def resource_id
    @rds_snapshot? @rds_snapshot[:db_snapshot_identifier]: ''
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

  private

  def get_resource(opts)
    catch_aws_errors do
      resp = @aws.rds_client.describe_db_snapshots(db_snapshot_identifier: opts[:db_snapshot_identifier])
      return if resp.db_snapshots.empty?

      resp.db_snapshots.first.to_h
    end
  end
end
