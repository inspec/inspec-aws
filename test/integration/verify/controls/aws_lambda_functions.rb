aws_lambda_function_name = attribute("aws_lambda_function_name", value: "", description: "")
aws_lambda_function_arn = attribute("aws_lambda_function_name", value: "", description: "")
aws_lambda_function_runtime = attribute("aws_lambda_function_runtime", value: "", description: "")
aws_lambda_function_role = attribute("aws_lambda_function_role", value: "", description: "")
aws_lambda_function_handler = attribute("aws_lambda_function_handler", value: "", description: "")
aws_lambda_function_description = attribute("aws_lambda_function_description", value: "", description: "")

control 'aws-lambda-functions-1.0' do
  impact 1.0
  title 'List all functions of the lambda function.'

  describe aws_lambda_functions do
    it { should exist }
  end
  
  describe aws_lambda_functions do
    its('function_names') { should include 'test_Lambda' }
    its('function_arns') { should include 'arn:aws:lambda:us-east-2:112758395563:function:test_Lambda' }
    its('runtimes') { should include 'python3.7' }
    its('roles') { should include 'arn:aws:iam::112758395563:role/aws-iam-role-bsqfbelcujbbpeahrnunhngxp' }
    its('handlers') { should include 'main.on_event' }
    its('code_sizes') { should include 422 }
    its('descriptions') { should include 'Test Lambda' }
    its('timeouts') { should include 10 }
    its('memory_sizes') { should include 128 }
    # its('last_modified') { should_not be_empty }
    its('code_sha_256') { should include 'WeXkUII6OO08dCVZ6gczLZW51uqN3fCcEO+cjTHKWU0=' }
    its('versions') { should include '$LATEST' }
    its('vpc_configs') { should_not be_empty }
    its('dead_letter_configs') { should_not be_empty }
    its('environments') { should_not be_empty }
    its('kms_key_arns') { should_not be_empty }
    its('tracing_configs') { should_not be_empty }
    its('master_arns') { should_not be_empty }
    its('revision_ids') { should_not be_empty }
    its('layers') { should_not be_empty }
    its('states') { should_not be_empty }
    its('state_reasons') { should_not be_empty }
    its('state_reason_codes') { should_not be_empty }
    its('last_update_statuses') { should_not be_empty }
    its('last_update_status_reasons') { should_not be_empty }
    its('last_update_status_reason_codes') { should_not be_empty }
    its('file_system_configs') { should_not be_empty }
  end
end