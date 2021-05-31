describe aws_api_gateway_method(rest_api_id: "rest_api_id", resource_id: 'resource_id', http_method: 'http_method', status_code: 'status_code') do
	it { should exist }
end

describe aws_api_gateway_method(rest_api_id: "rest_api_id", resource_id: 'resource_id', http_method: 'http_method', status_code: 'status_code') do
	its('status_code') { should eq 'status_code' }
	its('response_parameters') { should eq 'response_parameters' }
	its('response_parameters["String"]') { should eq true }
	its('response_models') { should eq 'test' }
	its('response_models["String"]') { should eq 'test' }
end

describe aws_api_gateway_method(rest_api_id: "dummy", resource_id: 'dummy', http_method: 'dummy', status_code: 'dummy') do
	its { should_not exist }
end