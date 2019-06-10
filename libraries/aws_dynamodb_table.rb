# frozen_string_literal: true

require 'aws_backend'

class AwsDynamodbTable < AwsResourceBase
  name 'aws_dynamodb_table'
  desc 'Verifies the settings for a DynamoDB table'

  example "
    describe aws_dynamo_db_table('table-name') do
      it { should exist }
    end
  "

  attr_reader :table_name, :table_status, :creation_date, :number_of_decreases_today,
              :write_capacity_units, :read_capacity_units, :item_count, :table_arn, :attributes, :key_schema

  def initialize(opts = {})
    opts = { table_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:table_name])

    catch_aws_errors do

      begin
        resp = @aws.dynamodb_client.describe_table(table_name: opts[:table_name])
        return nil if resp[0].nil? || resp[0].empty?
      rescue Aws::DynamoDB::Errors::ResourceNotFoundException
        return
      end

      @dynamodb_table = resp[0]
      @table_name                = @dynamodb_table[:table_name]
      @table_status              = @dynamodb_table[:table_status]
      @table_arn                 = @dynamodb_table[:table_arn]
      @creation_date             = @dynamodb_table[:creation_date_time].strftime("%m/%d/%Y")
      @number_of_decreases_today = @dynamodb_table[:provisioned_throughput][:number_of_decreases_today]
      @write_capacity_units      = @dynamodb_table[:provisioned_throughput][:write_capacity_units]
      @read_capacity_units       = @dynamodb_table[:provisioned_throughput][:read_capacity_units]
      @item_count                = @dynamodb_table[:item_count]
      @attributes                = []
      @key_schema                = []
      @secondary_global_table    = {}

      if @dynamodb_table[:attribute_definitions]
        @dynamodb_table[:attribute_definitions].map { |attr|
          @attributes.push({ 'attribute_name': attr.attribute_name,
                                 'attribute_type': attr.attribute_type })
        }
      end

      if @dynamodb_table[:key_schema]
        @dynamodb_table[:key_schema].map { |key|
          @key_schema.push({ 'attribute_name': key.attribute_name,
                                 'key_type':       key.key_type })
        }
      end

      if @dynamodb_table['global_secondary_indexes']
        @secondary_global_table = flatten_hash(@dynamodb_table['global_secondary_indexes'][0].to_h, "global_sec_indexes")
        create_resource_methods(@secondary_global_table)
      end
    end
  end

  def flatten_hash(param, prefix=nil)
    param.each_pair.reduce({}) do |a, (k, v)|
      v.is_a?(Hash) ? a.merge(flatten_hash(v, prefix)) : a.merge("#{prefix}_#{k}".to_sym => v)
    end
  end

  def exist?
    !@table_name.nil?
  end
  alias exists? exist?

  def to_s
    "AWS Dynamodb table #{@table_name}"
  end

end

