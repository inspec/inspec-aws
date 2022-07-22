skip_control 'aws-api-gateway-method-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway method.'
  
  describe aws_api_gateway_method(rest_api_id: '', resource_id: '', http_method: 'GET') do
      it { should exist }
    end

    describe aws_api_gateway_method(rest_api_id: '', resource_id: '', http_method: 'GET') do
      its('http_method') { should eq 'GET' }
      its('authorization_type') { should eq 'NONE' }
      its('authorizer_id') { should be_empty }
      its('api_key_required') { should eq false }
      its('request_validator_id') { should be_empty }
      its('operation_name') { should be_empty }
      its('request_parameters') { should be_empty }
      its('request_models') { should be_empty }
      its('method_responses.status_code') { should be_empty }
      its('method_responses.response_parameters') { should be_empty }
      its('method_responses.response_models') { should be_empty }
      its('method_integration.type') { should eq 'MOCK' }
      its('method_integration.http_method') { should be_empty }
      its('method_integration.uri') { should be_empty }
      its('method_integration.connection_type') { should be_empty }
      its('method_integration.connection_id') { should be_empty }
      its('method_integration.credentials') { should be_empty }
      its('method_integration.request_parameters') { should be_empty }
      # its('method_integration.request_templates') { should_not be_empty }
      its('method_integration.passthrough_behavior') { should eq 'WHEN_NO_MATCH' }
      its('method_integration.content_handling') { should be_empty }
      its('method_integration.timeout_in_millis') { should eq 29000 }
      its('method_integration.cache_namespace') { should eq '' }
      its('method_integration.cache_key_parameters') { should eq [] }
      its('method_integration.integration_responses.status_code') { should be_empty }
      its('method_integration.integration_responses.selection_pattern') { should be_empty }
      its('method_integration.integration_responses.response_parameters') { should be_empty }
      its('method_integration.integration_responses.response_parameters') { should be_empty }
      its('method_integration.integration_responses.response_templates') { should be_empty }
      its('method_integration.integration_responses.response_templates') { should be_empty }
      its('method_integration.integration_responses.content_handling') { should be_empty }
      its('method_integration.tls_config.insecure_skip_verification') { should be_empty }
      its('authorization_scopes') { should be_empty }
    end

    describe aws_api_gateway_method(rest_api_id: 'dummy', resource_id: 'dummy', http_method: 'GET') do
      it { should_not exist }
    end
  end