require 'aws_backend'

class AWSMQBrokers < AwsResourceBase
  name 'aws_mq_brokers'
  desc 'Describes a list of aws mq broker.'

  example "
    describe aws_mq_brokers do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:broker_arns,                    field: :broker_arn)
             .register_column(:broker_ids,                     field: :broker_id)
             .register_column(:broker_names,                   field: :broker_name)
             .register_column(:broker_states,                  field: :broker_state)
             .register_column(:created, field: :created)
             .register_column(:deployment_modes,               field: :deployment_mode)
             .register_column(:engine_types,                   field: :engine_type)
             .register_column(:propagate_tags, field: :propagate_tags)
             .register_column(:host_instance_types, field: :host_instance_type)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    broker_summaries_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.mq_client.list_brokers(pagination_options)
      end
      return broker_summaries_rows if !@api_response || @api_response.empty?
      @api_response.broker_summaries.each do |broker_summaries|
        broker_summaries_rows += [{
          broker_arn: broker_summaries.broker_arn,
                                    broker_id: broker_summaries.broker_id,
                                    broker_name: broker_summaries.broker_name,
                                    broker_state: broker_summaries.broker_state,
                                    created: broker_summaries.created,
                                    deployment_mode: broker_summaries.deployment_mode,
                                    engine_type: broker_summaries.engine_type,
                                    host_instance_type: broker_summaries.host_instance_type,
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = broker_summaries_rows
  end
end
