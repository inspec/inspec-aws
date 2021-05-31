describe aws_api_gateway_deployment(rest_api_id: "rest_api_id", deployment_id: 'deployment_id') do
	it { should exist }
end

describe aws_api_gateway_deployment(rest_api_id: "rest_api_id", deployment_id: 'deployment_id') do
	its('id') { should eq 'id' }
	its('description') { should eq 'description' }
	its('created_date') { should eq 'created_date' }
	its('api_summary') { should eq '' }
	its('api_summary.authorization_type') { should eq 'authorization_type' }
	its('api_summary.api_key_required') { should eq true }
end

describe aws_api_gateway_deployment(rest_api_id: "dummy", deployment_id: 'dummy') do
	its { should_not exist }
end