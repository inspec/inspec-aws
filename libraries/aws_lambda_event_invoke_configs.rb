require "aws_backend"

class AWSLambdaEventInvokeConfigs < AwsResourceBase
  name "aws_lambda_event_invoke_configs"
  desc "Gets information about the scalable targets in the specified namespace."

  example "
    describe aws_lambda_event_invoke_configs(function_name: 'FUNCTION_NAME') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:last_modified, field: :last_modified)
    .register_column(:function_arns, field: :function_arn)
    .register_column(:maximum_retry_attempts, field: :maximum_retry_attempts)
    .register_column(:maximum_event_age_in_seconds, field: :maximum_event_age_in_seconds)
    .register_column(:destination_configs, field: :destination_config)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(function_name))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: function_name must be provided" unless opts[:function_name] && !opts[:function_name].empty?
    @query_params[:function_name] = opts[:function_name]
    @table = fetch_data
  end

  def fetch_data
    rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.lambda_client.list_function_event_invoke_configs(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.function_event_invoke_configs.each do |resp|
        rows += [{ last_modified: resp.last_modified,
                   function_arn: resp.function_arn,
                   maximum_retry_attempts: resp.maximum_retry_attempts,
                   destination_config: resp.destination_config }]
      end
      break unless @api_response.next_marker
      @query_params[:next_marker] = @api_response.next_marker
    end
    rows
  end
end
