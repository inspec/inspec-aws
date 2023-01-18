aws_apigatewayv2_domain_name_domain_name = input(:aws_apigatewayv2_domain_name_domain_name, value: '', description: '')

control 'aws-api-gateway-v2-domain-names' do
  title 'Ensure API Gateway API Domain Names resource has the correct properties.'

  describe aws_api_gateway_v2_domain_names do
    it { should exist }
  end

  describe aws_api_gateway_v2_domain_names do
    its('api_mapping_selection_expressions') { should include '$request.basepath' }
    its('domain_names') { should include aws_apigatewayv2_domain_name_domain_name }
    its('domain_name_configurations') { should_not be_empty }
    its('mutual_tls_authentications') { should be_empty }
    its('tags') { should_not be_empty }
  end
end
