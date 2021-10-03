aws_lambda_function_event_invoke_config_function_name = attribute('aws_lambda_function_event_invoke_config_function_name', value: '', description: '')

control 'aws-lambda-event-invoke-configs-1.0' do
  impact 1.0
  title 'Retrieves a list of configurations for asynchronous invocation for a function.'

  describe aws_lambda_event_invoke_configs(function_name: aws_lambda_function_event_invoke_config_function_name) do
    it { should exist }
  end

  describe aws_lambda_event_invoke_configs(function_name: aws_lambda_function_event_invoke_config_function_name) do
    its('function_arns') { should_not be_empty }
    its('maximum_retry_attempts') { should include 0 }
    its('maximum_event_age_in_seconds') { should include 0 }
    its('destination_configs') { should_not be_empty }
  end
end