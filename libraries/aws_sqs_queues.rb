require 'aws_backend'

class AwsSqsQueues < AwsResourceBase
  name 'aws_sqs_queues'
  desc 'Verifies settings for a collection AWS SQS Queues.'
  example "
    describe aws_sqs_queues do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:arns,                                  field: :arn)
             .register_column(:queue_urls,                            field: :queue_url)
             .register_column(:is_fifo_queues,                        field: :is_fifo_queue)
             .register_column(:visibility_timeouts,                   field: :visibility_timeout)
             .register_column(:maximum_message_sizes,                 field: :maximum_message_size)
             .register_column(:message_retention_periods,             field: :message_retention_period)
             .register_column(:delay_seconds,                         field: :delay_seconds)
             .register_column(:receive_message_wait_timeout_seconds,  field: :receive_message_wait_timeout_seconds)
             .register_column(:content_based_deduplications,          field: :content_based_deduplication)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    queue_rows = []
    catch_aws_errors do
      response = @aws.sqs_client.list_queues
      return [] if !response || response.empty?
      response.queue_urls.each do |url|
        queue_attributes = @aws.sqs_client.get_queue_attributes(queue_url: url, attribute_names: ['All']).attributes
        queue_rows += [{ arn:                  queue_attributes['QueueArn'],
                         queue_url:            url,
                         attachment_count:     queue_attributes['VisibilityTimeout'].to_i,
                         default_version_id:   queue_attributes['MaximumMessageSize'].to_i,
                         policy_name:          queue_attributes['MessageRetentionPeriod'].to_i,
                         policy_id:            queue_attributes['DelaySeconds'].to_i,
                         attached_groups:      queue_attributes['ReceiveMessageWaitTimeoutSeconds'].to_i,
                         attached_roles:       queue_attributes['ContentBasedDeduplication'].nil? ? false: true,
                         attached_users:       queue_attributes['FifoQueue'].nil? ? false: true }]
      end
    end
    @table = queue_rows
  end
end
