aws_lambda_alias_name = input(:aws_lambda_alias_name, value: '', description: '')
aws_lambda_alias_function_name = input(:aws_lambda_alias_function_name, value: '', description: '')
aws_lambda_alias_arn = input(:aws_lambda_alias_arn, value: '', description: '')
aws_lambda_alias_description = input(:aws_lambda_alias_description, value: '', description: '')

control 'aws-lambda-aliases-1.0' do
  impact 1.0
  title 'Test the properties of the lambda aliases.'

  describe aws_lambda_aliases(function_name: aws_lambda_alias_function_name) do
    it { should exist }
  end

  describe aws_lambda_aliases(function_name: aws_lambda_alias_function_name) do
    its('alias_arns') { should include aws_lambda_alias_arn }
    its('names') { should include aws_lambda_alias_name }
    its('function_versions') { should include '$LATEST' }
    its('descriptions') { should include aws_lambda_alias_description }
    its('routing_configs') { should_not be_empty }
    its('revision_ids') { should_not be_empty }
  end
end
