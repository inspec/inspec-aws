require 'aws_backend'

class AWSApiGatewayUsagePlanKey < AwsResourceBase
  name 'aws_api_gateway_usage_plan_key'
  desc 'Gets a usage plan key of a given key identifier.'
  example <<-EXAMPLE
    describe aws_api_gateway_usage_plan_key(usage_plan_id: 'USAGE_PLAN_ID', key_id: 'USAGE_PLAN_KEY_ID') do
      it { should exist }
      its('id') { should eq 'USAGE_PLAN_KEY_ID' }
    end
  EXAMPLE

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(usage_plan_id key_id))
    raise ArgumentError, "#{@__resource_name__}: usage_plan_id must be provided" if opts[:usage_plan_id].blank?
    raise ArgumentError, "#{@__resource_name__}: key_id must be provided" if opts[:key_id].blank?
    @display_name = opts[:key_id]
    @usage_plan_id = opts[:usage_plan_id]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_usage_plan_key({ usage_plan_id: opts[:usage_plan_id], key_id: opts[:key_id] })
      @res = resp.to_h
      @usage_plan_key_id = @res[:id]
      @usage_plan_key_name = @res[:name]
      create_resource_methods(@res)
    end
  end

  def resource_id
    "#{@res? @usage_plan_key_id: @display_name}_#{@res? @usage_plan_key_name: ''}"
  end

  def exists?
    !@res.blank?
  end

  def key_id
    return unless exists?
    @res[:id]
  end

  def to_s
    "Usage Plan Key ID: #{@display_name}"
  end
end
