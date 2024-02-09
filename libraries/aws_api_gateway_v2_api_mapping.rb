require "aws_backend"

class AwsApiGatewayV2ApiMapping < AwsResourceBase
  name "aws_api_gateway_v2_api_mapping"
  desc "Gets an API mapping."
  example <<-EXAMPLE
    describe aws_api_gateway_v2_api_mapping(api_mapping_id: 'API_MAPPING_ID', domain_name: 'DOMAIN_NAME') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { api_mapping_id: opts, domain_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i[api_mapping_id domain_name])
    if opts[:api_mapping_id].blank?
      raise ArgumentError,
            "#{@__resource_name__}: api_mapping_id must be provided!"
    end
    if opts[:domain_name].blank?
      raise ArgumentError,
            "#{@__resource_name__}: domain_name must be provided!"
    end
    @display_name = opts[:api_mapping_id]
    catch_aws_errors do
      resp =
        @aws.apigatewayv2_client.get_api_mapping(
          {
            api_mapping_id: opts[:api_mapping_id],
            domain_name: opts[:domain_name]
          }
        )
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def api_mapping_id
    return nil unless exists?
    @res[:api_mapping_id]
  end

  def exists?
    !@res.blank?
  end

  def resource_id
    @res ? @res[:api_mapping_id] : @display_name
  end

  def to_s
    "API Mapping ID: #{@display_name}"
  end
end
