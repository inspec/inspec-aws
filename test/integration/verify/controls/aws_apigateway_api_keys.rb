aws_api_gateway_api_key_id = input(:aws_api_gateway_api_key_id, value: '', description: '')
aws_api_gateway_api_key_created_date = input(:aws_api_gateway_api_key_created_date, value: '', description: '')
aws_api_gateway_api_key_last_updated_date = input(:aws_api_gateway_api_key_last_updated_date, value: '', description: '')

control 'aws-apigateway-api-keys' do

  title 'Ensure API Gateway API Key resource has the correct properties.'

  describe aws_apigateway_api_keys do
    it { should exist }
  end

  describe aws_apigateway_api_keys do
    its('ids') { should include aws_api_gateway_api_key_id }
    its('values') { should_not be_empty }
    its('names') { should include 'aws_api_gateway_api_key_demo1' }
    its('descriptions') { should include 'Managed by Terraform' }
    its('enabled') { should include true }
    its('created_dates') { should include Time.parse(aws_api_gateway_api_key_created_date) }
    its('last_updated_dates') { should include Time.parse(aws_api_gateway_api_key_last_updated_date) }
    its('stage_keys') { should_not be_empty }
    its('tags') { should_not be_empty }
  end
end
