require "aws_backend"

class AwsCloudformationStack < AwsResourceBase
  name "aws_cloudformation_stack"
  desc "Verifies settings for an aws CloudFormation Stack."
  example <<-EXAMPLE
    describe aws_cloudformation_stack('STACK_NAME') do
      it { should exist }
    end
  EXAMPLE

  attr_reader :stack_id, :stack_name, :change_set_id, :description, :parameters, :creation_time, :deletion_time, :last_updated_time,
              :rollback_configuration, :stack_status, :stack_status_reason, :drift_information, :disable_rollback,
              :notification_arns, :timeout_in_minutes, :capabilities, :outputs, :role_arn, :tags, :enable_termination_protection,
              :parent_id, :root_id

  def initialize(opts = {})
    opts = { stack_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:stack_name])
    catch_aws_errors do
      name = { stack_name: opts[:stack_name] }
      resp = @aws.cloudformation_client.describe_stacks(name)
      return nil if resp.stacks.nil? || resp.stacks.empty?
      stack = resp.stacks.first
      @stack_id = stack.stack_id
      @stack_name = stack.stack_name
      @change_set_id = stack.change_set_id
      @description = stack.description
      @parameters = stack.parameters
      @creation_time = stack.creation_time.to_s
      @deletion_time = stack.deletion_time
      @last_updated_time = stack.last_updated_time
      @rollback_configuration = stack.rollback_configuration
      @stack_status = stack.stack_status
      @stack_status_reason = stack.stack_status_reason
      @drift_information = stack.drift_information
      @disable_rollback = stack.disable_rollback
      @notification_arns = stack.notification_arns
      @timeout_in_minutes = stack.timeout_in_minutes
      @capabilities = stack.capabilities
      @outputs = stack.outputs
      @role_arn = stack.role_arn
      @tags = stack.tags
      @enable_termination_protection = stack.enable_termination_protection
      @parent_id = stack.parent_id
      @root_id = stack.root_id
    end
  end

  def resource_id
    @stack_id
  end

  def exists?
    !@stack_name.nil?
  end

  def to_s
    "AWS CloudFormation Stack #{@stack_name}"
  end
end
