require 'aws_backend'

class AwsDynamoDbTable < AwsResourceBase
  name 'aws_dynamodb_table'
  desc 'Verifies the settings for a DynamoDB table.'

  example "
    describe aws_dynamodb_table(table_name: 'table-name') do
      it { should exist }
    end
  "

  attr_reader :table_name, :table_status, :creation_date, :number_of_decreases_today,
              :write_capacity_units, :read_capacity_units, :item_count, :table_arn, :attributes, :key_schema, :global_secondary_indexes,
              :sse_description

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
      @creation_date             = @dynamodb_table[:creation_date_time].strftime('%m/%d/%Y')
      @number_of_decreases_today = @dynamodb_table[:provisioned_throughput][:number_of_decreases_today]
      @write_capacity_units      = @dynamodb_table[:provisioned_throughput][:write_capacity_units]
      @read_capacity_units       = @dynamodb_table[:provisioned_throughput][:read_capacity_units]
      @item_count                = @dynamodb_table[:item_count]
      @sse_description           = @dynamodb_table[:sse_description]
      @attributes                = []
      @key_schema                = []
      @global_secondary_indexes  = []

      @dynamodb_table[:attribute_definitions]&.map { |attr|
        @attributes.push({ 'attribute_name': attr.attribute_name,
                           'attribute_type': attr.attribute_type })
      }
      @dynamodb_table[:key_schema]&.map { |key|
        @key_schema.push({ 'attribute_name': key.attribute_name,
                           'key_type':       key.key_type })
      }

      if @dynamodb_table[:global_secondary_indexes]
        gsi = { global_secondary_indexes: @dynamodb_table[:global_secondary_indexes] }
        create_resource_methods(gsi)
        global_secondary_indexes.each do |idx|
          idx.define_singleton_method(:to_s) do
            "AWS Dynamodb Global Secondary Index #{idx.item[:index_name]}"
          end
          idx.define_singleton_method(:key_schema) do
            idx.item[:key_schema].map { |attr| { 'attribute_name': attr[:attribute_name], 'key_type': attr[:key_type] } }
          end
        end
      end
    end
  end

  def resource_id
    @table_arn
  end

  def encrypted?
    @dynamodb_table.dig(:sse_description, :status)&.upcase == 'ENABLED' || false
  end

  def exists?
    !@dynamodb_table.nil?
  end

  def to_s
    "AWS Dynamodb table #{@table_name}"
  end
end
