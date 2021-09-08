# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayV2APIMapping < AwsResourceBase
  name 'aws_api_gatewayv2_api_mapping'
  desc 'Gets an API mapping.'

  example "
    describe aws_api_gatewayv2_api_mapping(api_mapping_id: 'api_mapping_id', domain_name: 'domain_name') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { api_mapping_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(api_mapping_id domain_name))
    raise ArgumentError, "#{@__resource_name__}: api_mapping_id must be provided" unless opts[:api_mapping_id] && !opts[:api_mapping_id].empty?
    raise ArgumentError, "#{@__resource_name__}: domain_name must be provided" unless opts[:domain_name] && !opts[:domain_name].empty?
    @display_name = opts[:api_mapping_id]
    catch_aws_errors do
      resp = @aws.apigatewayv2_client.get_api_mapping({ api_mapping_id: opts[:api_mapping_id], domain_name: opts[:domain_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def api_mapping_id
    return nil unless exists?
    @res[:api_mapping_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "API Mapping ID: #{@display_name}"
  end
end
