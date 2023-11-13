require 'aws_backend'

class AWSLambdaVersions < AwsResourceBase
  name 'aws_lambda_versions'
  desc 'Lists the versions of an Lambda layer.'

  example "
    describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:layer_version_arns, field: :layer_version_arn)
             .register_column(:versions, field: :version)
             .register_column(:descriptions, field: :description)
             .register_column(:created_dates, field: :created_date)
             .register_column(:compatible_runtimes, field: :compatible_runtimes)
             .register_column(:license_infos, field: :license_info)
             .register_column(:compatible_architectures, field: :compatible_architectures)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(layer_name))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: layer_name must be provided" unless opts[:layer_name] && !opts[:layer_name].empty?
    @query_params[:layer_name] = opts[:layer_name]
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.lambda_client.list_layer_versions(@query_params).map do |table|
        table.layer_versions.map { |table_name| {
          layer_version_arn: table_name.layer_version_arn,
          version: table_name.version,
          description: table_name.description,
          created_date: table_name.created_date,
          compatible_runtimes: table_name.compatible_runtimes,
          license_info: table_name.license_info,
          compatible_architectures: table_name.compatible_architectures,
        }
        }
      end.flatten
    end
  end
end
