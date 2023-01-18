require "aws_backend"

class AWSMQConfigurations < AwsResourceBase
  name "aws_mq_configurations"
  desc "Describes a list of aws mq broker."

  example "
    describe aws_mq_configurations do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:arns, field: :arn)
    .register_column(:authentication_strategies, field: :authentication_strategy)
    .register_column(:description, field: :description)
    .register_column(:created, field: :created)
    .register_column(:engine_types, field: :engine_type)
    .register_column(:ids, field: :id)
    .register_column(:names, field: :name)
    .register_column(:engine_version, field: :engine_version)
    .register_column(:tags,                   field: :tags)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    configuration_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.mq_client.list_configurations(pagination_options)
      end
      return configuration_rows if !@api_response || @api_response.empty?
      @api_response.configurations.each do |configurations|
        configuration_rows += [{
          arn: configurations.arn,
          authentication_strategy: configurations.authentication_strategy,
          description: configurations.description,
          created: configurations.created,
          engine_version: configurations.engine_version,
          engine_type: configurations.engine_type,
          id: configurations.id,
          name: configurations.name,
          tags: configurations.tags,
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = configuration_rows
  end
end
