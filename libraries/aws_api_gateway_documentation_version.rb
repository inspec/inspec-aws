require "aws_backend"

class AWSApiGatewayDocumentationVersion < AwsResourceBase
  name "aws_api_gateway_documentation_version"
  desc "Retrieves API Gateway Documentation Version."

  example "
    describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id documentation_version))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: documentation_version must be provided" unless opts[:documentation_version] && !opts[:documentation_version].empty?
    @display_name = opts[:documentation_version]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_documentation_version({ rest_api_id: opts[:rest_api_id], documentation_version: opts[:documentation_version] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def resource_id
    @display_name
  end

  def documentation_version
    return nil unless exists?
    @res[:documentation_version]
  end

  def to_s
    "Documentation Version: #{@display_name}"
  end
end
