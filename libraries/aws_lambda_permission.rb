require "aws_backend"

class AWSLambdaPermission < AwsResourceBase
  name "aws_lambda_permission"
  desc "Returns the resource-based IAM policy for a function, version, or alias."

  example "
    describe aws_lambda_permission(function_name: 'LambdaFunctionName', Sid: 'StatementID') do
      its('sid') { should eq 'StatementID' }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(function_name Sid))
    raise ArgumentError, "#{@__resource_name__}: function_name must be provided" unless opts[:function_name] && !opts[:function_name].empty?
    raise ArgumentError, "#{@__resource_name__}: statement_id must be provided" unless opts[:Sid] && !opts[:Sid].empty?
    @statement_id = opts[:Sid]
    row = {}
    catch_aws_errors do
      resp = @aws.lambda_client.get_policy({ function_name: opts[:function_name] })
      statements = JSON.parse(resp.policy)["Statement"]
      statements.each do |value|
        next if value["Sid"] != opts[:Sid]
        row = {
          sid: value["Sid"],
          effect: value["Effect"],
          principal: value["Principal"]["Service"],
          action: value["Action"],
          resource: value["Resource"],
        }
      end
      create_resource_methods(row.to_h)
    end
  end

  def resource_id
    @statement_id
  end

  def to_s
    "Statement ID: #{@statement_id}"
  end
end
