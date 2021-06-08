# frozen_string_literal: true

require 'aws_backend'

class AWSECSService < AwsResourceBase
  name 'aws_ecs_service'
  desc 'Describes the specified services running in your cluster.'

  example "
    describe aws_ecs_service(cluster: 'test-cluster', services: 'test1') do
      it { should exist }
    end
  "
  def initialize(opts = {})
    opts = { services: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(services), require_any_of: %i(cluster))
    raise ArgumentError, "#{@__resource_name__}: services must be provided" unless opts[:services] && !opts[:services].empty?
    raise ArgumentError, "#{@__resource_name__}: cluster must be provided" unless opts[:cluster] && !opts[:cluster].empty?
    @display_name = opts[:services]
    catch_aws_errors do
      resp = @aws.ecs_client.describe_services({ cluster: opts[:cluster], services: [opts[:services]] })
      @services = resp.services[0].to_h
      create_resource_methods(@services)
    end
  end

  def id
    return nil unless exists?
    @services[:services]
  end

  def exists?
    !@services.nil? && !@services.empty?
  end

  def encrypted?
    @services[:encrypted]
  end

  def to_s
    "Service: #{@display_name}"
  end
end
