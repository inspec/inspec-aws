# frozen_string_literal: true

require 'aws_backend'

class AWSLambdaEventSourceMappings < AwsResourceBase
  name 'aws_lambda_event_source_mappings'
  desc ''
  example `
    describe aws_lambda_event_source_mappings do
      it { should exist }
    end
  `

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
    catch_aws_errors do
      @resp = @aws.lambda_client.list_event_source_mappings
    end
    require "pry"; binding.pry
    return [] if !@resp || @resp.empty?
    @table = @resp.event_source_mappings.map(&:to_h)
  end
end
