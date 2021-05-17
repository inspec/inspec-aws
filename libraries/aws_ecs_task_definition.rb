# frozen_string_literal: true

require 'aws_backend'

class AWSECSTaskDefinition < AwsResourceBase
  name 'aws_ecs_task_definition'
  desc 'Returns information about the endpoints for your account in the current region.'

  example "
    describe aws_ecs_task_definition(task_definition: 'test1') do
      it { should exist }
    end
  "
  def initialize(opts = {})
    opts = { task_definition: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:task_definition])

    raise ArgumentError, "#{@__resource_name__}: task_definition must be provided" unless opts[:task_definition] && !opts[:task_definition].empty?
    @display_name = opts[:task_definition]
    catch_aws_errors do
      resp = @aws.ecs_client.describe_task_definition({ task_definition: opts[:task_definition] })
      @container_definitions = resp.task_definition.to_h
    #   require 'pry'; binding.pry
      create_resource_methods(@container_definitions)
    end
  end

  def id
    return nil unless exists?
    @container_definitions[:task_definition]
  end

  def exists?
    !@container_definitions.nil? && !@container_definitions.empty?
  end

  def encrypted?
    @container_definitions[:encrypted]
  end

  def to_s
    "endpoint_identifier: #{@display_name}"
  end
end
