require 'aws_backend'

class AWSCloudFormationStackSet < AwsResourceBase
  name 'aws_cloud_formation_stack_set'
  desc 'Describes the specified stack set.'

  example "
    describe aws_cloud_formation_stack_set(stack_set_name: 'StackSetName') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { stack_set_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:stack_set_name])
    raise ArgumentError, "#{@__resource_name__}: stack_set_name must be provided" unless opts[:stack_set_name] && !opts[:stack_set_name].empty?
    @display_name = opts[:stack_set_name]
    resp = @aws.cloudformation_client.describe_stack_set({ stack_set_name: opts[:stack_set_name] })
    @resp = resp.stack_set.to_h
    @stack_set_id = @resp[:stack_set_id]
    create_resource_methods(@resp)
  end

  def resource_id
    @stack_set_id
  end

  def stack_set_name
    return nil unless exists?
    @resp[:stack_set_name]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "Stack Set Name: #{@display_name}"
  end

  def parameter_keys
    parameters.map(&:parameter_key)
  end

  def parameter_values
    parameters.map(&:parameter_value)
  end

  def use_previous_values
    parameters.map(&:use_previous_value)
  end

  def resolved_values
    parameters.map(&:resolved_value)
  end
end
