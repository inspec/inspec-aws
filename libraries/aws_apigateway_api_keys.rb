require "aws_backend"

class AWSApiGatewayAPIKeys < AwsResourceBase
  name "aws_apigateway_api_keys"
  desc "Gets information about the current ApiKeys resource."

  example "
    describe aws_apigateway_api_keys do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:ids, field: :id)
    .register_column(:values, field: :value)
    .register_column(:names, field: :name)
    .register_column(:customer_ids, field: :customer_id)
    .register_column(:descriptions, field: :description)
    .register_column(:enabled, field: :enabled)
    .register_column(:created_dates, field: :created_date)
    .register_column(:last_updated_dates, field: :last_updated_date)
    .register_column(:stage_keys, field: :stage_keys)
    .register_column(:tags, field: :tags)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.apigateway_client.get_api_keys.map do |table|
        table.items.map { |table_name| {
          id: table_name.id,
          value: table_name.value,
          name: table_name.name,
          customer_id: table_name.customer_id,
          description: table_name.description,
          enabled: table_name.enabled,
          created_date: table_name.created_date,
          last_updated_date: table_name.last_updated_date,
          stage_keys: table_name.stage_keys,
          tags: table_name.tags,
        }
        }
      end.flatten
    end
  end
end
