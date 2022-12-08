require "aws_backend"

class AWSApiGatewayBasePathMappings < AwsResourceBase
  name "aws_apigateway_base_path_mappings"
  desc "Represents a collection of BasePathMapping resources."

  example "
    describe aws_apigateway_base_path_mappings(domain_name: 'DomainName') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:base_paths, field: :base_path)
    .register_column(:rest_api_ids, field: :rest_api_id)
    .register_column(:stages, field: :stage)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(domain_name))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: domain_name must be provided" unless opts[:domain_name] && !opts[:domain_name].empty?
    @query_params[:domain_name] = opts[:domain_name]
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.apigateway_client.get_base_path_mappings(@query_params).map do |table|
        table.items.map { |table_name| {
          base_path: table_name.base_path,
          rest_api_id: table_name.rest_api_id,
          stage: table_name.stage,
        }
        }
      end.flatten
    end
  end
end
