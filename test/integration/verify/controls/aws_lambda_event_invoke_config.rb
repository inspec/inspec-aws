aws_lambda_function_event_invoke_config_function_name = attribute('aws_lambda_function_event_invoke_config_function_name', value: '', description: '')

control 'aws-lambda-event-invoke-config-1.0' do
  impact 1.0
  title 'Retrieves the configuration for asynchronous invocation for a function, version, or alias.'

  describe aws_lambda_event_invoke_config(function_name: aws_lambda_function_event_invoke_config_function_name) do
    it { should exist }
  end

  describe aws_lambda_event_invoke_config(function_name: aws_lambda_function_event_invoke_config_function_name) do
    its('function_arn') { should eq 'arn:aws:lambda:us-east-2:112758395563:function:lambda_function_name123:$LATEST' }
    its('maximum_retry_attempts') { should eq 0 }
    its('maximum_event_age_in_seconds') { should eq 60 }
    its('on_success_destination') { should be_empty }
    its('on_faliure_destination') { should be_empty }
  end
end