aws_lambda_event_source_mapping_uuid = input(:aws_lambda_event_source_mapping_uuid, value: '', description: '')
aws_lambda_event_source_mapping_function_arn = input(:aws_lambda_event_source_mapping_function_arn, value: '', description: '')
aws_lambda_event_source_mapping_last_processing_result = input(:aws_lambda_event_source_mapping_last_processing_result, value: '', description: '')
aws_lambda_event_source_mapping_state = input(:aws_lambda_event_source_mapping_state, value: '', description: '')
aws_lambda_event_source_mapping_state_transition_reason = input(:aws_lambda_event_source_mapping_state_transition_reason, value: '', description: '')

title 'Test single AWS Lambda Source Mapping'

control 'aws-lambda-source-mapping-1.0' do
  title 'Ensure AWS Lambda Source Mapping has the correct properties.'

  describe aws_lambda_event_source_mapping(uuid: aws_lambda_event_source_mapping_uuid) do
    it { should exist }
  end
  
  describe aws_lambda_event_source_mapping(uuid: aws_lambda_event_source_mapping_uuid) do
    its('uuid') { should eq aws_lambda_event_source_mapping_uuid }
    its('starting_position') { should_not eq  'LATEST' }
    its('starting_position_timestamp') { should be_empty }
    its('batch_size') { should eq 1 }
    its('maximum_batching_window_in_seconds') { should eq 0 }
    its('event_source_arn') { should_not be_empty }
    its('function_arn') { should eq aws_lambda_event_source_mapping_function_arn }
    its('last_processing_result') { should eq aws_lambda_event_source_mapping_last_processing_result }
    its('state') { should eq aws_lambda_event_source_mapping_state }
    its('state_transition_reason') { should eq aws_lambda_event_source_mapping_state_transition_reason }
  end
end
