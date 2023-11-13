require 'aws_backend'

class AwsDynamoDbTables < AwsResourceBase
  name 'aws_dynamodb_tables'
  desc 'Verifies settings for a DynamoDB table in bulk.'
  example <<-EXAMPLE
    describe aws_dynamodb_tables do
      it { should exist }
    end

    aws_dynamodb_tables.where(table_names: 'table_name').table_names.each do |table|
      describe aws_dynamodb_table(table_name: table) do
        it { should exist }
        it { should be_encrypted }
      end
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:table_names, field: :table_names)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.dynamodb_client.list_tables.map do |table|
        table.table_names.map { |table_name| { table_names: table_name } }
      end.flatten
    end
  end
end
