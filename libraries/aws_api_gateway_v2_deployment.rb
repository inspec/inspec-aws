require "aws_backend"

class AwsApiGatewayV2Deployment < AwsResourceBase
  name "aws_api_gateway_v2_deployment"
  desc "Gets a Deployment."
  example <<-EXAMPLE
    describe aws_api_gateway_v2_deployment(api_id: 'APP_ID', deployment_id: 'DEPLOYMENT_ID') do
      it { should exist }
      its('deployment_id') { should eq 'DEPLOYMENT_ID' }
      its('deployment_status') { should eq 'DEPLOYED' }
      its('authorizer_type') { should eq 'JWT' }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_id: opts, deployment_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id deployment_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided!" if opts[:api_id].blank?
    raise ArgumentError, "#{@__resource_name__}: deployment_id must be provided!" if opts[:deployment_id].blank?
    @display_name = opts[:deployment_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_deployment({ api_id: opts[:api_id], deployment_id: opts[:deployment_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def deployment_id
    return nil unless exists?
    @res[:deployment_id]
  end

  def exists?
    !@res.blank?
  end

  def resource_id
    @res? @res[:deployment_id]: @display_name
  end

  def to_s
    "Deployment ID: #{@display_name}"
  end
end
