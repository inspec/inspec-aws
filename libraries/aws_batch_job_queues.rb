require "aws_backend"

class AWSBatchJobQueues < AwsResourceBase
  name "aws_batch_job_queues"
  desc "Describes one or more of your job queues."
  example <<-EXAMPLE
    describe aws_batch_job_queues do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
    .register_column(:job_queue_names,                             field: :job_queue_name)
    .register_column(:job_queue_arns,                              field: :job_queue_arn)
    .register_column(:states,                                      field: :state)
    .register_column(:statuses,                                    field: :status)
    .register_column(:status_reasons,                              field: :status_reason)
    .register_column(:priorities,                                  field: :priority)
    .register_column(:tags,                                        field: :tags)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    job_queue_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.batch_client.describe_job_queues(pagination_options)
      end
      return job_queue_rows if !@api_response || @api_response.empty?
      @api_response.job_queues.each do |job_queue|
        job_queue_rows += [{
          job_queue_name: job_queue.job_queue_name,
          job_queue_arn: job_queue.job_queue_arn,
          state: job_queue.state,
          status: job_queue.status,
          status_reason: job_queue.status_reason,
          priority: job_queue.priority,
          tags: map_tags(job_queue[:tags]),
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = job_queue_rows
  end
end
