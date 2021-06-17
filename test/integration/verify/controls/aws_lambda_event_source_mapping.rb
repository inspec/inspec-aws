aws_lambda_event_source_mapping_uuid = attribute(:aws_lambda_event_source_mapping_uuid, value: '', description: '')
aws_lambda_event_source_mapping_event_source_arn = attribute(:aws_lambda_event_source_mapping_event_source_arn, value: '', description: '')
aws_lambda_event_source_mapping_function_arn = attribute(:aws_lambda_event_source_mapping_function_arn, value: '', description: '')
aws_lambda_event_source_mapping_last_modified = attribute(:aws_lambda_event_source_mapping_last_modified, value: '', description: '')
aws_lambda_event_source_mapping_last_processing_result = attribute(:aws_lambda_event_source_mapping_last_processing_result, value: '', description: '')
aws_lambda_event_source_mapping_state = attribute(:aws_lambda_event_source_mapping_state, value: '', description: '')
aws_lambda_event_source_mapping_state_transition_reason = attribute(:aws_lambda_event_source_mapping_state_transition_reason, value: '', description: '')

title 'Test single AWS Lambda Source Mapping'
control 'aws-lambda-source-mapping-1.0' do

  impact 1.0
  title 'Ensure AWS Lambda Source Mapping has the correct properties.'

  describe aws_lambda_event_source_mapping(uuid: aws_lambda_event_source_mapping_uuid) do
    it { should exist }
  end
  
  describe aws_lambda_event_source_mapping(uuid: aws_lambda_event_source_mapping_uuid) do
    its('uuid') { should eq aws_lambda_event_source_mapping_uuid }
    its('starting_position') { should eq 'LATEST' }
    its('starting_position_timestamp') { should eq '' }
    its('batch_size') { should eq 1 }
    its('maximum_batching_window_in_seconds') { should eq 1 }
    its('parallelization_factor') { should eq 1 }
    its('event_source_arn') { should eq aws_lambda_event_source_mapping_event_source_arn }
    its('function_arn') { should eq aws_lambda_event_source_mapping_function_arn }
    its('last_modified') { should eq aws_lambda_event_source_mapping_last_modified }
    its('last_processing_result') { should eq aws_lambda_event_source_mapping_last_processing_result }
    its('state') { should eq aws_lambda_event_source_mapping_state }
    its('state_transition_reason') { should eq aws_lambda_event_source_mapping_state_transition_reason }
    its('destination_config.on_success.destination') { should eq '' }
    its('destination_config.on_failure.destination') { should eq '' }
    its('topics') { should include '' }
    its('queues') { should include '' }
    its('source_access_configurations') { should include '' }
    its('source_access_configurations.first.type') { should eq 'BASIC_AUTH' }
    its('source_access_configurations.first.uri') { should eq '' }
    its('maximum_record_age_in_seconds') { should eq 1 }
    its('bisect_batch_on_function_error') { should eq 1 }
    its('maximum_retry_attempts') { should eq 1 }
  end
end