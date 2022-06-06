# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayResource < AwsResourceBase
  name 'aws_api_gateway_resource'
  desc 'Gets information about a resource.'
  example <<-EXAMPLE
    describe aws_api_gateway_resource(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id resource_id))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" if opts[:rest_api_id].blank?
    raise ArgumentError, "#{@__resource_name__}: resource_id must be provided" if opts[:resource_id].blank?
    @display_name = opts[:resource_id]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_resource({ rest_api_id: opts[:rest_api_id], resource_id: opts[:resource_id] })
      @res = resp.to_h
      @id = @res[:id]
      @parent_id = @res[:parent_id]
      @path_part = @res[:path_part]
      @path = @res[:path]
      @resource_methods_res = resp.resource_methods.to_h
      require 'pry'; binding.pry
      create_resource_methods(@resource_methods_res)
    end
  end

  def resource_id
    @res? "#{@id}_#{@parent_id}": @display_name
  end

  def exists?
    !@res.blank?
  end

  def to_s
    "Resource ID: #{@display_name}"
  end
end
