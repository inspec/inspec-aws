# frozen_string_literal: true

require 'aws_backend'

class AwsDynamoDbTable < AwsResourceBase
  name 'aws_dynamodb_table'
  desc 'Verifies the settings for a DynamoDB table'

  example "
    describe aws_dynamodb_table(table_name: 'table-name') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { table_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:table_name])
    @display_name = opts[:table_name]

    catch_aws_errors do
      resp = @aws.dynamodb_client.describe_table({ table_name: opts[:table_name] })
      if resp.table.first.empty?
        empty_response_warn
      else
        @table = resp.table.to_h
        create_resource_methods(@table)
      end
    end
  end

  def encrypted?
    return false unless @table[:sse_description]
    @table[:sse_description][:status].upcase == 'ENABLED'
  end

  def exists?
    !failed_resource?
  end

  def to_s
    "AWS Dynamodb table #{@display_name}"
  end
end
