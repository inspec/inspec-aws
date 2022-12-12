require "aws_backend"

class AWSBatchComputeEnvironment < AwsResourceBase
  name "aws_batch_compute_environment"
  desc "Describes one or more of your compute environments."
  example <<-EXAMPLE
    describe aws_batch_compute_environment(compute_environment_name: 'BATCH_COMPUTE_ENVIRONMENT_NAME') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { compute_environment_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:compute_environment_name])

    raise ArgumentError, "#{@__resource_name__}: compute_environment_name must be provided" unless opts[:compute_environment_name] && !opts[:compute_environment_name].empty?
    @display_name = opts[:compute_environment_name]
    catch_aws_errors do
      resp = @aws.batch_client.describe_compute_environments({ compute_environments: [opts[:compute_environment_name]] })
      @compute_environments = resp.compute_environments[0].to_h
      create_resource_methods(@compute_environments)
    end
  end

  def compute_environment_name
    return nil unless exists?
    @compute_environments[:compute_environment_name]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@compute_environments.nil? && !@compute_environments.empty?
  end

  def to_s
    "Compute Environment Name: #{@display_name}"
  end
end
