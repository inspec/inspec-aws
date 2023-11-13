require 'aws_backend'

class AWSApiGatewayStage < AwsResourceBase
  name 'aws_api_gateway_stage'
  desc 'Gets information about a Stage resource.'
  example <<-EXAMPLE
    describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(rest_api_id stage_name))
    raise ArgumentError, "#{@__resource_name__}: rest_api_id must be provided" unless opts[:rest_api_id] && !opts[:rest_api_id].empty?
    raise ArgumentError, "#{@__resource_name__}: stage_name must be provided" unless opts[:stage_name] && !opts[:stage_name].empty?
    @display_name = opts[:stage_name]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_stage({ rest_api_id: opts[:rest_api_id], stage_name: opts[:stage_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def stage_name
    return unless exists?
    @res[:stage_name]
  end

  def resource_id
    @res? @res[:stage_name] : @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Stage Name: #{@display_name}"
  end
end
