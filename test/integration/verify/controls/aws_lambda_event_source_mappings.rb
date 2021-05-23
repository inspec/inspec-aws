
describe aws_lambda_event_source_mappings do
    it { should exist }
  end
  
  describe aws_lambda_event_source_mappingsdo
    its('uuids') { should include '' }
    its('starting_positions') { should include '' }
    its('starting_position_timestamps') { should include '' }
    its('batch_sizes') { should include 1 }
    its('maximum_batching_window_in_seconds') { should include 1 }
    its('parallelization_factors') { should include 1 }
    its('event_source_arnss') { should include '' }
    its('function_arns') { should include '' }
    its('last_modified') { should include '' }
    its('last_processing_results') { should include '' }
    its('states') { should include '' }
    its('state_transition_reasons') { should include '' }
    its('destination_configs') { should include '' }
    its('destination_config.on_failure.destination') { should include '' }
    its('topics') { should include '' }
    its('queues') { should include '' }
    its('source_access_configurations') { should include '' }
    its('maximum_record_age_in_seconds') { should include 1 }
    its('bisect_batch_on_function_errors') { should include 1 }
    its('maximum_retry_attempts') { should include 1 }
  end