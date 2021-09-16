# frozen_string_literal: true

require 'aws_backend'

class AWSCloudFormationCloudResource < AwsResourceBase
  name 'aws_cloudformation_custom_resource'
  desc 'Gets information about the current ApiKey resource.'

  example "
    describe aws_cloudformation_custom_resource(stack_name: 'StackName', logical_resource_id: 'LogicalResourceId') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { stack_name: opts } if opts.is_a?(String)
    opts = { logical_resource_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(stack_name logical_resource_id))
    raise ArgumentError, "#{@__resource_name__}: stack_name must be provided" unless opts[:stack_name] && !opts[:stack_name].empty?
    raise ArgumentError, "#{@__resource_name__}: logical_resource_id must be provided" unless opts[:logical_resource_id] && !opts[:logical_resource_id].empty?
    @display_name = opts[:stack_name]
    catch_aws_errors do
      resp = @aws.cloudformation_client.describe_stack_resource({ stack_name: opts[:stack_name], logical_resource_id: opts[:logical_resource_id] })
      @res = resp.stack_resource_detail.to_h
      create_resource_methods(@res)
    end
  end

  def stack_name
    return nil unless exists?
    @res[:stack_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Stack Name: #{@display_name}"
  end
end
