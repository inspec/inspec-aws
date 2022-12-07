require 'aws_backend'

class AWSApiGatewayDocumentationVersions < AwsResourceBase
  name 'aws_api_gateway_documentation_versions'
  desc 'Lists all the API Gateway documentation Version.'

  example "
    describe aws_api_gateway_documentation_versions(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end
    describe aws_api_gateway_documentation_versions(rest_api_id: 'REST_API_ID') do
      its('versions') { should include 'VERSION' }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:versions, field: :version)
             .register_column(:created_dates, field: :created_date)
             .register_column(:descriptions, field: :description)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.apigateway_client.get_documentation_versions(rest_api_id: opts[:rest_api_id]).map do |table|
        table.items.map { |table_name| {
          version: table_name.version,
          created_date: table_name.created_date,
          description: table_name.description,
        }
        }
      end.flatten
    end
  end
end
