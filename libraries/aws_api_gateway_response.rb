require "aws_backend"

class AWSApiGatewayResponse < AwsResourceBase
  name "aws_api_gateway_response"
  desc "Retrieves API Gateway Response."
  example <<-EXAMPLE
    describe aws_api_gateway_response(rest_api_id: 'REST_API_ID', response_type: 'RESPONSE_TYPE') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i[rest_api_id response_type])
    unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
      raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided"
    end
    unless opts[:response_type] && !opts[:response_type].empty?
      raise ArgumentError,
            "#{@__resource_name__}: response_type must be provided"
    end
    @display_name = opts[:response_type]
    catch_aws_errors do
      resp =
        @aws.apigateway_client.get_gateway_response(
          {
            rest_api_id: opts[:rest_api_id],
            response_type: opts[:response_type]
          }
        )
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def response_type
    return nil unless exists?
    @res[:response_type]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Response Type: #{@display_name}"
  end
end
