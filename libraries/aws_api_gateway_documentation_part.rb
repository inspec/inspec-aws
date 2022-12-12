require "aws_backend"

class AWSApiGatewayDocumentationPart < AwsResourceBase
  name "aws_api_gateway_documentation_part"
  desc "Retrieves API Gateway Documentation part."
  example <<-EXAMPLE
    describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id documentation_part_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: documentation_part_id must be provided" unless opts[:documentation_part_id] && !opts[:documentation_part_id].empty?
    @display_name = opts[:documentation_part_id]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_documentation_part({ rest_api_id: opts[:rest_api_id], documentation_part_id: opts[:documentation_part_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def documentation_part_id
    return nil unless exists?
    @res[:documentation_part_id]
  end

  def resource_id
    @res[:id]
  end

  def to_s
    "Documentation Part ID: #{@display_name}"
  end
end
