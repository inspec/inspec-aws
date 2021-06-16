# frozen_string_literal: true

require 'aws_backend'

class AWSECSTaskDefinition < AwsResourceBase
  name 'aws_ecs_task_definition'
  desc 'Describes a task definition.'

  example "
    describe aws_ecs_task_definition(task_definition: 'hello_world:8') do
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

  def names
    container_definitions.map{|x| x.name}
  end

  def images
    container_definitions.map{|x| x.images}
  end

  def cpus
    container_definitions.map{|x| x.cpu}
  end

  def memories
    container_definitions.map{|x| x.memory}
  end

  def port_mappings
    container_definitions.map{|x| x.port_mappings}
  end

  def to_s
    "Task Definition Name: #{@display_name}"
  end
end
