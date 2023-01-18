aws_lambda_event_source_mapping_uuid = input(:aws_lambda_event_source_mapping_uuid, value: '', description: '')
aws_lambda_event_source_mapping_function_arn = input(:aws_lambda_event_source_mapping_function_arn, value: '', description: '')
aws_lambda_event_source_mapping_last_processing_result = input(:aws_lambda_event_source_mapping_last_processing_result, value: '', description: '')
aws_lambda_event_source_mapping_state = input(:aws_lambda_event_source_mapping_state, value: '', description: '')
aws_lambda_event_source_mapping_state_transition_reason = input(:aws_lambda_event_source_mapping_state_transition_reason, value: '', description: '')

title 'Test single AWS Lambda Source Mappings'

control 'aws-lambda-source-mappings-1.0' do
  title 'Ensure AWS Lambda Source Mappings has the correct properties.'

  describe aws_lambda_event_source_mappings do
    it { should exist }
  end
  
  describe aws_lambda_event_source_mappings do
    its('uuids') { should include aws_lambda_event_source_mapping_uuid }
    its('starting_positions') { should_not be_empty }
    its('starting_position_timestamps') { should_not be_empty }
    its('batch_sizes') { should include 1 }
    its('maximum_batching_window_in_seconds') { should include 0 }
    its('event_source_arns') { should_not be_empty }
    its('function_arns') { should include aws_lambda_event_source_mapping_function_arn }
    its('last_processing_results') { should include aws_lambda_event_source_mapping_last_processing_result }
    its('states') { should include aws_lambda_event_source_mapping_state }
    its('state_transition_reasons') { should include aws_lambda_event_source_mapping_state_transition_reason }
   end
end
