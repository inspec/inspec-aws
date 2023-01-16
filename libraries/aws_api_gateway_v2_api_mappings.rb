require "aws_backend"

class AwsApiGatewayV2ApiMappings < AwsCollectionResourceBase
  name "aws_api_gateway_v2_api_mappings"
  desc "Gets API mappings."
  example <<-EXAMPLE
    describe aws_api_gateway_v2_api_mappings(domain_name: 'DOMAIN_NAME') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { domain_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(domain_name))
    raise ArgumentError, "#{@__resource_name__}: domain_name must be provided!" if opts[:domain_name].blank?
    @table = fetch(client: :apigatewayv2_client, operation: :get_api_mappings, kwargs: { domain_name: opts[:domain_name] }).items.map(&:to_h)
    populate_filter_table_from_response
  end
end
