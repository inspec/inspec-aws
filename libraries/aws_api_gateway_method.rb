require "aws_backend"

class AWSApiGatewayMethod < AwsResourceBase
  name "aws_api_gateway_method"
  desc "Describe an existing Method resource."
  example <<-EXAMPLE
    describe aws_api_gateway_method(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID', http_method: 'GET') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { rest_api_id: opts, resource_id: opts, http_method: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(rest_api_id resource_id http_method))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: resource_id must be provided" unless opts[:resource_id] && !opts[:resource_id].empty?
    raise ArgumentError, "#{@__resource_name__}: http_method must be provided" unless opts[:http_method] && !opts[:http_method].empty?
    @rest_api_id = opts[:rest_api_id]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_method({ rest_api_id: opts[:rest_api_id], resource_id: opts[:resource_id], http_method: opts[:http_method] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def rest_api_id
    return unless exists?
    @res[:rest_api_id]
  end

  def resource_id
    @res ? "#{@res[:operation_name]}_#{@res[:authorizer_id]}" : @rest_api_id
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Rest API ID: #{@rest_api_id}"
  end
end
