require 'aws_backend'

class AWSLambdaEventSourceMappings < AwsResourceBase
  name 'aws_lambda_event_source_mappings'
  desc 'Lists event source mappings.'

  example "
    describe aws_lambda_event_source_mappings do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:uuids,                                                                   field: :uuid)
             .register_column(:starting_positions,                                                      field: :starting_position)
             .register_column(:starting_position_timestamps,                                            field: :starting_position_timestamp)
             .register_column(:batch_sizes,                                                             field: :batch_size)
             .register_column(:maximum_batching_window_in_seconds,                                      field: :maximum_batching_window_in_seconds)
             .register_column(:parallelization_factors,                                                 field: :parallelization_factor)
             .register_column(:event_source_arns,                                                       field: :event_source_arn)
             .register_column(:function_arns,                                                           field: :function_arn)
             .register_column(:last_modified,                                                           field: :last_modified)
             .register_column(:last_processing_results,                                                 field: :last_processing_result)
             .register_column(:states,                                                                  field: :state)
             .register_column(:state_transition_reasons,                                                field: :state_transition_reason)
             .register_column(:destination_configs,                                                     field: :destination_config)
             .register_column(:topics,                                                                  field: :topics)
             .register_column(:queues,                                                                  field: :queues)
             .register_column(:source_access_configurations,                                            field: :source_access_configurations)
             .register_column(:maximum_record_age_in_seconds,                                           field: :maximum_record_age_in_seconds)
             .register_column(:bisect_batch_on_function_errors,                                         field: :bisect_batch_on_function_error)
             .register_column(:maximum_retry_attempts,                                                  field: :maximum_retry_attempts)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    rows = []
    query_params = {}
    query_params[:max_items] = 20
    loop do
      catch_aws_errors do
        @api_response = @aws.lambda_client.list_event_source_mappings(query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.event_source_mappings.each do |resp|
        rows += [{ uuid: resp.uuid,
                   starting_position: resp.starting_position,
                   starting_position_timestamp: resp.starting_position_timestamp,
                   batch_size: resp.batch_size,
                   maximum_batching_window_in_seconds: resp.maximum_batching_window_in_seconds,
                   parallelization_factor: resp.parallelization_factor,
                   event_source_arn: resp.event_source_arn,
                   function_arn: resp.function_arn,
                   last_modified: resp.last_modified,
                   last_processing_result: resp.last_processing_result,
                   state: resp.state,
                   state_transition_reason: resp.state_transition_reason,
                   destination_config: resp.destination_config,
                   topics: resp.topics,
                   queues: resp.queues,
                   source_access_configurations: resp.source_access_configurations,
                   maximum_record_age_in_seconds: resp.maximum_record_age_in_seconds,
                   bisect_batch_on_function_error: resp.bisect_batch_on_function_error,
                   maximum_retry_attempts: resp.maximum_retry_attempts }]
      end
      break unless @api_response.next_marker
      query_params[:marker] = @api_response.next_marker
    end
    rows
  end
end
