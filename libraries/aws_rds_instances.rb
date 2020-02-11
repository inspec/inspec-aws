# frozen_string_literal: true

require 'aws_backend'

class AwsRdsInstances < AwsResourceBase
  name 'aws_rds_instances'
  desc 'Verifies settings for AWS RDS instances in bulk'
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

  FilterTable.create
             .register_column(:tags, field: :tags)
             .register_column(:db_instance_identifiers, field: :db_instance_identifier)
             .register_column(:cluster_identifiers,     field: :cluster_identifier)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    rds_instance_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.rds_client.describe_db_instances(**pagination_options)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.db_instances.each do |rds_instance|
        rds_instance_rows += [{
          db_instance_identifier: rds_instance.db_instance_identifier,
                                db_name: rds_instance.db_name,
        }]
      end
      break unless @api_response.marker
      pagination_options = { marker: @api_response[:marker] }
    end
    @table = rds_instance_rows
  end
end
