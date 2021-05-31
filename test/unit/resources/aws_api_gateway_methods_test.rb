describe aws_api_gateway_methods(rest_api_id: "rest_api_id", resource_id: 'resource_id', http_method: 'http_method', status_code: 'status_code') do
	it { should exist }
end

describe aws_api_gateway_methods(rest_api_id: "rest_api_id", resource_id: 'resource_id', http_method: 'http_method', status_code: 'status_code') do
	its('http_method') { should eq 'http_method' }
	its('authorization_type') { should eq 'test' }
	its('authorizer_id') { should eq 'test' }
	its('api_key_required') { should eq true }
	its('request_validator_id') { should eq 'test' }
	its('operation_name') { should eq 'test' }
	its('request_parameters') { should eq 'test' }
	its('request_parameters["String"]') { should eq true }
	its('request_models') { should eq 'test' }
	its('request_models["String"]') { should eq 'test' }
	its('method_responses') { should eq 'test' }
	its('method_responses["String"].status_code') { should eq 'test' }
	its('method_responses["String"].response_parameters') { should eq 'test' }
	its('method_responses["String"].response_parameters["String"]') { should eq true }
	its('method_responses["String"].response_models') { should eq 'test' }
	its('method_responses["String"].response_models["String"]') { should eq 'test' }
	its('method_integration.type') { should eq 'test' }
	its('method_integration.http_method') { should eq 'test' }
	its('method_integration.uri') { should eq 'test' }
	its('method_integration.connection_type') { should eq 'test' }
	its('method_integration.connection_id') { should eq 'test' }
	its('method_integration.credentials') { should eq 'test' }
	its('method_integration.request_parameters #=> Hash
	its('method_integration.request_parameters["String"]') { should eq 'test' }
	its('method_integration.request_templates #=> Hash
	its('method_integration.request_templates["String"]') { should eq 'test' }
	its('method_integration.passthrough_behavior') { should eq 'test' }
	its('method_integration.content_handling') { should eq 'test' }
	its('method_integration.timeout_in_millis') { should eq 1 }
	its('method_integration.cache_namespace') { should eq 'test' }
	its('method_integration.cache_key_parameters') { should eq 'test' }
	its('method_integration.cache_key_parameters[0]') { should eq 'test' }
	its('method_integration.integration_responses #=> Hash
	its('method_integration.integration_responses["String"].status_code') { should eq 'test' }
	its('method_integration.integration_responses["String"].selection_pattern') { should eq 'test' }
	its('method_integration.integration_responses["String"].response_parameters') { should eq 'test' }
	its('method_integration.integration_responses["String"].response_parameters["String"]') { should eq 'test' }
	its('method_integration.integration_responses["String"].response_templates') { should eq 'test' }
	its('method_integration.integration_responses["String"].response_templates["String"]') { should eq 'test' }
	its('method_integration.integration_responses["String"].content_handling') { should eq 'test' }, one of "CONVERT_TO_BINARY", "CONVERT_TO_TEXT"
	its('method_integration.tls_config.insecure_skip_verification') { should eq true }
	its('authorization_scopes') { should eq 'test' }
	its('authorization_scopes[0]') { should eq 'test' }
end

describe aws_api_gateway_methods(rest_api_id: "dummy", resource_id: 'dummy', http_method: 'dummy', status_code: 'dummy') do
	its { should_not exist }
end