require "aws_backend"

class AwsApiGatewayV2Integration < AwsResourceBase
  name "aws_api_gateway_v2_integration"
  desc "Gets an Integration."
  example <<-EXAMPLE
    describe aws_api_gateway_v2_integration(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
      it { should exist }
      its('integration_id') { should eq 'INTEGRATION_ID' }
      its('connection_id') { should eq 'CONNECTION_ID' }
      its('connection_type') { should eq 'INTERNET' }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_id: opts, integration_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id integration_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided!" if opts[:api_id].blank?
    raise ArgumentError, "#{@__resource_name__}: integration_id must be provided!" if opts[:integration_id].blank?
    @display_name = opts[:integration_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_integration({ api_id: opts[:api_id], integration_id: opts[:integration_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def integration_id
    return unless exists?
    @res[:integration_id]
  end

  def exists?
    !@res.blank?
  end

  def resource_id
    @res? @res[:integration_id]: @display_name
  end

  def to_s
    "Integration ID: #{@display_name}"
  end
end
