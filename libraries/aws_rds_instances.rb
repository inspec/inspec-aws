require 'aws_backend'

class AwsRdsInstances < AwsCollectionResourceBase
  name 'aws_rds_instances'
  desc 'Verifies settings for AWS RDS instances in bulk.'
  example "
    describe aws_rds_instances do
      it { should exist }
    end

    describe aws_rds_instances do
      its('entries.count') { should be > 1 }
    end

    # Iterate through all instances
    aws_rds_instances.db_instance_identifiers.each do |db_instance_identifier|
      describe aws_rds_instance(db_instance_identifier) do
        it { should have_encrypted_storage }
        it { should be_encrypted }
      end
    end
  "

  attr_reader :table

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch(client: :rds_client, operation: :describe_db_instances).db_instances.map(&:to_h)

    populate_filter_table_from_response
  end

  def exist?
    !@table.empty?
  end
end
