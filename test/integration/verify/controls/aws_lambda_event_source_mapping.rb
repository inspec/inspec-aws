describe aws_lambda_event_source_mapping(uuid: 'test1') do
    it { should exist }
  end
  
  describe aws_lambda_event_source_mapping(uuid: 'test1') do
    its('uuid') { should eq '' }
    its('starting_position') { should eq '' }
    its('starting_position_timestamp') { should eq '' }
    its('batch_size') { should eq 1 }
    its('maximum_batching_window_in_seconds') { should eq 1 }
    its('parallelization_factor') { should eq 1 }
    its('event_source_arn') { should eq '' }
    its('function_arn') { should eq '' }
    its('last_modified') { should eq '' }
    its('last_processing_result') { should eq '' }
    its('state') { should eq '' }
    its('state_transition_reason') { should eq '' }
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