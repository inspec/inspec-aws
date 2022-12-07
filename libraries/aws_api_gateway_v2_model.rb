require 'aws_backend'

class AwsApiGatewayV2Model < AwsResourceBase
  name 'aws_api_gateway_v2_model'
  desc 'Gets a Model.'
  example <<-EXAMPLE
    describe aws_api_gateway_v2_model(api_id: 'APP_ID', model_id: 'MODEL_ID') do
      it { should exist }
      its('model_id') { should eq 'MODEL_ID' }
      its('name') { should eq 'MODEL_NAME' }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_id: opts, model_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_id model_id))
    raise ArgumentError, "#{@__resource_name__}: api_id must be provided!" if opts[:api_id].blank?
    raise ArgumentError, "#{@__resource_name__}: model_id must be provided!" if opts[:model_id].blank?
    @display_name = opts[:model_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_model({ api_id: opts[:api_id], model_id: opts[:model_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def model_id
    return nil unless exists?
    @res[:model_id]
  end

  def exists?
    !@res.blank?
  end

  def resource_id
    @res? @res[:model_id]: @display_name
  end

  def to_s
    "Model ID: #{@display_name}"
  end
end
