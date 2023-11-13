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
    validate_parameters(required: %i(service), require_any_of: %i(cluster))
    raise ArgumentError, "#{@__resource_name__}: services must be provided" unless opts[:service] && !opts[:service].empty?
    raise ArgumentError, "#{@__resource_name__}: cluster must be provided" unless opts[:cluster] && !opts[:cluster].empty?
    @display_name = opts[:service]
    catch_aws_errors do
      resp = @aws.ecs_client.describe_services({ cluster: opts[:cluster], services: [opts[:service]] })
      @services = resp.services[0].to_h
      create_resource_methods(@services)
    end
  end

  def services
    return unless exists?
    @services[:services]
  end

  def resource_id
    return @display_name unless exists?
    @services[:service_arn]
  end

  def exists?
    !@services.nil? && !@services.empty?
  end

  def to_s
    "Service: #{@display_name}"
  end
end
