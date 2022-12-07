require 'aws_backend'

class AWSApiGatewayAccount < AwsResourceBase
  name 'aws_apigateway_account'
  desc 'Gets information about the current Account resource.'

  example "
    describe aws_apigateway_account do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters
    catch_aws_errors do
      resp = @aws.apigateway_client.get_account
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def resource_id
    @res? @res[:cloudwatch_role_arn] : ''
  end

  def exists?
    !@res.nil? && !@res.empty?
  end
end
