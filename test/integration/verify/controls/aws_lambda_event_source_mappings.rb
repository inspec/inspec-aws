aws_lambda_event_source_mapping_uuid = attribute(:aws_lambda_event_source_mapping_uuid, value: '', description: '')
aws_lambda_event_source_mapping_event_source_arn = attribute(:aws_lambda_event_source_mapping_event_source_arn, value: '', description: '')
aws_lambda_event_source_mapping_function_arn = attribute(:aws_lambda_event_source_mapping_function_arn, value: '', description: '')
aws_lambda_event_source_mapping_last_modified = attribute(:aws_lambda_event_source_mapping_last_modified, value: '', description: '')
aws_lambda_event_source_mapping_last_processing_result = attribute(:aws_lambda_event_source_mapping_last_processing_result, value: '', description: '')
aws_lambda_event_source_mapping_state = attribute(:aws_lambda_event_source_mapping_state, value: '', description: '')
aws_lambda_event_source_mapping_state_transition_reason = attribute(:aws_lambda_event_source_mapping_state_transition_reason, value: '', description: '')

title 'Test single AWS Lambda Source Mappings'
control 'aws-lambda-source-mappings-1.0' do

  impact 1.0
  title 'Ensure AWS Lambda Source Mappings has the correct properties.'

  describe aws_lambda_event_source_mappings do
    it { should exist }
  end
  
  describe aws_lambda_event_source_mappingsdo
    its('uuids') { should include aws_lambda_event_source_mapping_uuid }
    its('starting_positions') { should include 'LATEST' }
    its('starting_position_timestamps') { should include '' }
    its('batch_sizes') { should include 1 }
    its('maximum_batching_window_in_seconds') { should include 1 }
    its('parallelization_factors') { should include 1 }
    its('event_source_arns') { should include aws_lambda_event_source_mapping_event_source_arn }
    its('function_arns') { should include aws_lambda_event_source_mapping_function_arn }
    its('last_modified') { should include aws_lambda_event_source_mapping_last_modified }
    its('last_processing_results') { should include aws_lambda_event_source_mapping_last_processing_result }
    its('states') { should include aws_lambda_event_source_mapping_state }
    its('state_transition_reasons') { should include aws_lambda_event_source_mapping_state_transition_reason }
    its('destination_configs') { should include '' }
    its('destination_config.on_failure.destination') { should include '' }
    its('topics') { should include '' }
    its('queues') { should include '' }
    its('source_access_configurations') { should include '' }
    its('maximum_record_age_in_seconds') { should include 1 }
    its('bisect_batch_on_function_errors') { should include 1 }
    its('maximum_retry_attempts') { should include 1 }
  end
end