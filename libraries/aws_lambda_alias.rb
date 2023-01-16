require "aws_backend"

class AWSLambdaAlias < AwsResourceBase
  name "aws_lambda_alias"
  desc "Retrieves information about a patch baseline."

  example "
    describe aws_lambda_alias(function_name: 'FUNCTION_NAME', function_alias_name: 'FUNCTION_ALIAS_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(function_name function_alias_name))
    raise ArgumentError, "#{@__resource_name__}: function_name must be provided" unless opts[:function_name] && !opts[:function_name].empty?
    raise ArgumentError, "#{@__resource_name__}: function_alias_name must be provided" unless opts[:function_alias_name] && !opts[:function_alias_name].empty?
    @display_name = opts[:function_alias_name]
    catch_aws_errors do
      resp = @aws.lambda_client.get_alias({ function_name: opts[:function_name], name: opts[:function_alias_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def function_alias_name
    return nil unless exists?
    @res[:function_alias_name]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Function Alias Name: #{@display_name}"
  end
end
