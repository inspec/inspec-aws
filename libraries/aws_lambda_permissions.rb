require "aws_backend"

class AWSLambdaPermissions < AwsResourceBase
  name "aws_lambda_permissions"
  desc "Returns the resource-based IAM policy for a function, version, or alias."

  example "
    describe aws_lambda_permissions(function_name: 'LambdaFunctionName') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:sids,                                  field: :sid)
    .register_column(:effects,                               field: :effect)
    .register_column(:principals,                            field: :principal)
    .register_column(:actions,                               field: :action)
    .register_column(:resources,                             field: :resource)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(function_name))
    raise ArgumentError, "#{@__resource_name__}: function_name must be provided" unless opts[:function_name] && !opts[:function_name].empty?
    @table = fetch_data
  end

  def fetch_data
    rows = []
    catch_aws_errors do
      resp = @aws.lambda_client.get_policy({ function_name: opts[:function_name] })
      statements = JSON.parse(resp.policy)["Statement"]
      statements.each do |value|
        rows += [{
          sid: value["Sid"],
                  effect: value["Effect"],
                  principal: value["Principal"]["Service"],
                  action: value["Action"],
                  resource: value["Resource"],
        }]
      end
      rows
    end
  end
end
