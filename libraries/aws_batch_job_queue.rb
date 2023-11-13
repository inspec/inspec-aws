require "aws_backend"

class AWSBatchJobQueue < AwsResourceBase
  name "aws_batch_job_queue"
  desc "Describes one or more of your job queues."
  example <<-EXAMPLE
    describe aws_batch_job_queue(job_queue_name: 'JOB_QUEUE_NAME') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { job_queue_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:job_queue_name])

    raise ArgumentError, "#{@__resource_name__}: job_queue_name must be provided" unless opts[:job_queue_name] && !opts[:job_queue_name].empty?
    @display_name = opts[:job_queue_name]
    catch_aws_errors do
      resp = @aws.batch_client.describe_job_queues({ job_queues: [opts[:job_queue_name]] })
      @job_queues = resp.job_queues[0].to_h
      create_resource_methods(@job_queues)
    end
  end

  def job_queue_name
    return unless exists?
    @job_queues[:job_queue_name]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@job_queues.nil? && !@job_queues.empty?
  end

  def to_s
    "Job Queue Name: #{@display_name}"
  end
end
