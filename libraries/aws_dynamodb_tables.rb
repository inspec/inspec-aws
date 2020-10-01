# frozen_string_literal: true

require 'aws_backend'

class AwsDynamoDbTables < AwsResourceBase
  name 'aws_dynamodb_tables'
  desc 'Verifies settings for a DynamoDB table in bulk'
  example '
    describe aws_dynamodb_tables do
      it { should exist }
    end
  '

  attr_reader :table, :api_response

  FilterTable.create
             .register_column(:table_names, field: :table_names)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    table_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.dynamodb_client.list_tables(pagination_options)
      end
      return [] if !api_response || api_response.empty?

      api_response.table_names.each { |table| table_rows += [{ table_names: table }] }

      break unless api_response.last_evaluated_table_name
      pagination_options = { last_evaluated_table_name: api_response[:last_evaluated_table_name] }
    end
    @table = table_rows
  end
end
