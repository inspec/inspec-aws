require "aws_backend"

class AWSApiGatewayDeployment < AwsResourceBase
  name "aws_api_gateway_deployment"
  desc "Gets information about a Deployment resource."
  example <<-EXAMPLE
    describe aws_api_gateway_deployment(rest_api_id: 'REST_API_ID', deployment_id: 'DEPLOYMENT_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id deployment_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: deployment_id must be provided" unless opts[:deployment_id] && !opts[:deployment_id].empty?
    @display_name = opts[:rest_api_id]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_deployment({ rest_api_id: opts[:rest_api_id], deployment_id: opts[:deployment_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def rest_api_id
    return nil unless exists?
    @res[:rest_api_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "REST API ID: #{@display_name}"
  end
end
