require 'aws_backend'

class AWSApiGatewayDocumentationParts < AwsResourceBase
  name 'aws_api_gateway_documentation_parts'
  desc 'Lists all the API Gateway documentation parts.'

  example "
    describe aws_api_gateway_documentation_parts(rest_api_id: REST_API_ID) do
      it { should exist }
    end

    describe aws_api_gateway_documentation_parts(rest_api_id: REST_API_ID) do
      its('ids') { should include DOCUMENTATION_PART_ID' }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids, field: :id)
             .register_column(:types, field: :type)
             .register_column(:paths, field: :path)
             .register_column(:methods, field: :method)
             .register_column(:status_codes, field: :status_code)
             .register_column(:names, field: :name)
             .register_column(:properties, field: :properties)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.apigateway_client.get_documentation_parts(rest_api_id: opts[:rest_api_id]).map do |table|
        table.items.map { |table_name| {
          id: table_name.id,
          type: table_name.location.type,
          path: table_name.location.path,
          method: table_name.location.method,
          status_code: table_name.location.status_code,
          name: table_name.location.name,
          properties: table_name.properties,
        }
        }
      end.flatten
    end
  end
end
