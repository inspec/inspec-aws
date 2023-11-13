require "aws_backend"

class AWSApiGatewayModel < AwsResourceBase
  name "aws_api_gateway_model"
  desc "Retrieves an API Gateway Model."
  example <<-EXAMPLE
    describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id model_name))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: model_name must be provided" unless opts[:model_name] && !opts[:model_name].empty?
    @display_name = opts[:model_name]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_model({ rest_api_id: opts[:rest_api_id], model_name: opts[:model_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def model_name
    return unless exists?
    @res[:model_name]
  end

  def resource_id
    @res? @res[:id] : @display_name
  end

  def to_s
    "Model Name: #{@display_name}"
  end
end
