# frozen_string_literal: true

require 'aws_backend'

class AWSCloudFormationStackSet < AwsResourceBase
  name 'aws_cloud_formation_stack_set'
  desc 'Describes the specified stack set.'

  example "
    describe aws_cloud_formation_stack_set(stack_set_name: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { stack_set_name: opts } if opts.is_a?(String)
    super(opts)
    valstack_set_nameate_parameters(required: [:stack_set_name])

    raise ArgumentError, "#{@__resource_name__}: stack_set_name must be provstack_set_nameed" unless opts[:stack_set_name] && !opts[:stack_set_name].empty?
    @display_name = opts[:stack_set_name]
    resp = @aws.cloudformation_client.describe_stack_set({ stack_set_name: opts[:stack_set_name] })
    @stack_set= resp.stack_set.to_h
    create_resource_methods(@stack_set)
  end

  def stack_set_name
    return nil unless exists?
    @stack_set[:stack_set_name]
  end

  def exists?
    !@stack_set.nil? && !@stack_set.empty?
  end

  def encrypted?
    @stack_set[:encrypted]
  end

  def to_s
    "Origin request policy ID: #{@display_name}"
  end
end
