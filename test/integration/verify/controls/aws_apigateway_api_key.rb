aws_api_gateway_api_key_id = input(:aws_api_gateway_api_key_id, value: '', description: '')
aws_api_gateway_api_key_created_date = input(:aws_api_gateway_api_key_created_date, value: '', description: '')
aws_api_gateway_api_key_last_updated_date = input(:aws_api_gateway_api_key_last_updated_date, value: '', description: '')

control 'aws-apigateway-api-key' do
  impact 1.0
  title 'Ensure API Gateway API Key resource has the correct properties.'

  describe aws_apigateway_api_key(api_key: aws_api_gateway_api_key_id) do
    it { should exist }
  end

  describe aws_apigateway_api_key(api_key: aws_api_gateway_api_key_id) do
    its('id') { should eq aws_api_gateway_api_key_id }
    its('value') { should be_empty }
    its('name') { should eq 'aws_api_gateway_api_key_demo1' }
    its('description') { should eq 'Managed by Terraform' }
    its('enabled') { should eq true }
    its('created_date') { should eq Time.parse(aws_api_gateway_api_key_created_date) }
    its('last_updated_date') { should eq Time.parse(aws_api_gateway_api_key_last_updated_date) }
    its('stage_keys') { should be_empty }
    its('tags') { should be_empty }
  end
end