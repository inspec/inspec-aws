require "aws_backend"

class AWSLambdaCodeSigningConfig < AwsResourceBase
  name "aws_lambda_code_signing_config"
  desc "Returns information about the specified code signing configuration."

  example "
    describe aws_lambda_code_signing_config(code_signing_config_arn: 'CODE_SIGNING_CONFIG_ARN') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(code_signing_config_arn))
    raise ArgumentError, "#{@__resource_name__}: code_signing_config_arn must be provided" unless opts[:code_signing_config_arn] && !opts[:code_signing_config_arn].empty?
    @display_name = opts[:code_signing_config_arn]
    catch_aws_errors do
      resp = @aws.lambda_client.get_code_signing_config({ code_signing_config_arn: opts[:code_signing_config_arn] })
      @res = resp.code_signing_config.to_h
      create_resource_methods(@res)
    end
  end

  def code_signing_config_arn
    return nil unless exists?
    @res[:code_signing_config_arn]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Code Signing Config ARN: #{@display_name}"
  end
end
