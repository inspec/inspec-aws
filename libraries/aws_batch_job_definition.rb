require "aws_backend"

class AWSBatchJobDefinition < AwsResourceBase
  name "aws_batch_job_definition"
  desc "Describes a list of job definitions."

  example "
    describe aws_batch_job_definition(job_definition_name: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { job_definition_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:job_definition_name])

    raise ArgumentError, "#{@__resource_name__}: job_definition_name must be provided" unless opts[:job_definition_name] && !opts[:job_definition_name].empty?
    @display_name = opts[:job_definition_name]
    resp = @aws.batch_client.describe_job_definitions({ job_definition_name: opts[:job_definition_name] })
    @job_definitions = resp.job_definitions[0].to_h
    create_resource_methods(@job_definitions)
  end

  def job_definition_name
    return nil unless exists?
    @job_definitions[:job_definition_name]
  end

  def exists?
    !@job_definitions.nil? && !@job_definitions.empty?
  end

  def resource_id
    @display_name
  end

  def encrypted?
    @job_definitions[:encrypted]
  end

  def to_s
    "Job Definition Name: #{@display_name}"
  end
end
