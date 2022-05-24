# frozen_string_literal: true

require 'aws_backend'

class AWSApiGatewayUsagePlan < AwsResourceBase
  name 'aws_api_gateway_usage_plan'
  desc 'Gets a usage plan of a given plan identifier.'
  example "
    describe aws_api_gateway_usage_plan(usage_plan_id: 'USAGE_PLAN_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(usage_plan_id))
    raise ArgumentError, "#{@__resource_name__}: usage_plan_id must be provided" if opts[:usage_plan_id].blank?
    @display_name = opts[:usage_plan_id]
    catch_aws_errors do
      resp = @aws.apigateway_client.get_usage_plan({ usage_plan_id: opts[:usage_plan_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def resource_id
    @res[:id]
  end

  def exists?
    !@res.blank?
  end

  def usage_plan_id
    return nil unless exists?
    @res[:usage_plan_id]
  end

  def api_stages_api_ids
    api_stages.map(&:api_id)
  end

  def api_stages_stages
    api_stages.map(&:stage)
  end

  def api_stages_throttles
    api_stages.map(&:throttle)
  end

  def to_s
    "Usage Plan ID: #{@display_name}"
  end
end
