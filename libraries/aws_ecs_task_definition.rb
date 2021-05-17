# frozen_string_literal: true

require 'aws_backend'

class AWSECSTaskDefinition < AwsResourceBase
  name 'aws_ecs_task_definition'
  desc 'Returns information about the endpoints for your account in the current region.'

  example "
    describe aws_ecs_task_definition(task_definition: 'test1:1') do
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
      @task_definition = resp.task_definition.to_h
      create_resource_methods(@task_definition)
    end
  end

  def id
    return nil unless exists?
    @task_definition[:task_definition]
  end

  def exists?
    !@task_definition.nil? && !@task_definition.empty?
  end

  def encrypted?
    @task_definition[:encrypted]
  end

  def to_s
    "Task Definition Name: #{@display_name}"
  end
end
