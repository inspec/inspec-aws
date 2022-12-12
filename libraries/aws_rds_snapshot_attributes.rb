require "aws_backend"

class AwsRdsSnapshotAttributes < AwsResourceBase
  name "aws_rds_snapshot_attributes"
  desc "Verifies settings for an RDS snapshot attributes."

  example '
    describe aws_rds_snapshot_attributes(db_snapshot_identifier: "test") do
      it { should exist }
    end
  '

  attr_reader :table

  FilterTable.create
    .register_column(:db_snapshot_identifier,    field: :db_snapshot_identifier)
    .register_column(:attribute_name,            field: :attribute_name)
    .register_column(:attribute_values,          field: :attribute_values)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    opts = { db_snapshot_identifier: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:db_snapshot_identifier])
    raise ArgumentError, "#{@__resource_name__}: db_snapshot_identifier must start with a letter followed by up to 1 to 255 characters." if opts[:db_snapshot_identifier] !~ /^[a-z]{1}[0-9a-z\-\:]{1,255}$/
    catch_aws_errors do
      @display_name = opts[:db_snapshot_identifier]

      begin
        @aws.rds_client.describe_db_snapshots(db_snapshot_identifier: opts[:db_snapshot_identifier])
      rescue Aws::RDS::Errors::DBSnapshotNotFound
        fail_resource("DBSnapshot does not exist")
      end
    end
    @table = fetch_data
  end

  private

  def fetch_data
    db_snapshot_rows = []
    catch_aws_errors do
      response = @aws.rds_client.describe_db_snapshot_attributes(db_snapshot_identifier: opts[:db_snapshot_identifier])
      return [] if !response || response.empty?
      response.db_snapshot_attributes_result.db_snapshot_attributes.each do |db_snapshot_attribute|
        db_snapshot_rows += [{ db_snapshot_identifier:         response.db_snapshot_attributes_result.db_snapshot_identifier,
                               attribute_name:                 db_snapshot_attribute.attribute_name,
                               attribute_values:               db_snapshot_attribute.attribute_values }]
      end
    end
    @table = db_snapshot_rows
  end
end
