require "aws_backend"

class AWSApiGatewayResource < AwsResourceBase
  name "aws_api_gateway_resource"
  desc "Gets information about a Resource."
  example <<-EXAMPLE
    describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { rest_api_id: opts, resource_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(rest_api_id resource_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided !" if opts[:rest_api_id].blank?
    raise ArgumentError, "#{@__resource_name__}: resource_id must be provided !" if opts[:resource_id].blank?
    @display_name = opts[:resource_id]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_resource({ rest_api_id: opts[:rest_api_id], resource_id: opts[:resource_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def resource_id
    @res? "#{@res[:id]}_#{@res[:parent_id]}": @display_name
  end

  def exists?
    !@res.blank?
  end

  def to_s
    "Resource ID: #{@display_name}"
  end
end
