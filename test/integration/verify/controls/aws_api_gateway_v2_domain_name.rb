aws_apigatewayv2_domain_name_domain_name = input(:aws_apigatewayv2_domain_name_domain_name, value: '', description: '')
aws_apigatewayv2_domain_name_certificate_arn = input(:aws_apigatewayv2_domain_name_certificate_arn, value: '', description: '')
aws_apigatewayv2_domain_name_endpoint_type = input(:aws_apigatewayv2_domain_name_endpoint_type, value: '', description: '')
aws_apigatewayv2_domain_name_hosted_zone_id = input(:aws_apigatewayv2_domain_name_hosted_zone_id, value: '', description: '')
aws_apigatewayv2_domain_name_ownership_verification_certificate_arn = input(:aws_apigatewayv2_domain_name_ownership_verification_certificate_arn, value: '', description: '')
aws_apigatewayv2_domain_name_security_policy = input(:aws_apigatewayv2_domain_name_security_policy, value: '', description: '')
aws_apigatewayv2_domain_name_target_domain_name = input(:aws_apigatewayv2_domain_name_target_domain_name, value: '', description: '')

control 'aws-api-gateway-v2-domain-name' do
  title 'Ensure API Gateway API Domain Name resource has the correct properties.'

  describe aws_api_gateway_v2_domain_name(domain_name: aws_apigatewayv2_domain_name_domain_name) do
    it { should exist }
  end

  describe aws_api_gateway_v2_domain_name(domain_name: aws_apigatewayv2_domain_name_domain_name) do
    its('api_mapping_selection_expression') { should eq '$request.basepath' }
    its('domain_name') { should eq aws_apigatewayv2_domain_name_domain_name }
    its('domain_name_configurations') { should_not be_empty }
    its('mutual_tls_authentication.truststore_uri') { should be_empty }
    its('mutual_tls_authentication.truststore_version') { should be_empty }
    its('mutual_tls_authentication.truststore_warnings') { should be_empty }
    its('tags') { should be_empty }
  end

  describe aws_api_gateway_v2_domain_name(domain_name: aws_apigatewayv2_domain_name_domain_name) do
    its('domain_name_configurations.first.api_gateway_domain_name') { should eq aws_apigatewayv2_domain_name_target_domain_name }
    its('domain_name_configurations.first.certificate_arn') { should eq aws_apigatewayv2_domain_name_certificate_arn }
    its('domain_name_configurations.first.certificate_name') { should be_empty }
    its('domain_name_configurations.first.certificate_upload_date') { should be_empty }
    its('domain_name_configurations.first.domain_name_status') { should eq 'AVAILABLE' }
    its('domain_name_configurations.first.domain_name_status_message') { should be_empty }
    its('domain_name_configurations.first.endpoint_type') { should eq aws_apigatewayv2_domain_name_endpoint_type }
    its('domain_name_configurations.first.hosted_zone_id') { should eq aws_apigatewayv2_domain_name_hosted_zone_id }
    its('domain_name_configurations.first.security_policy') { should eq aws_apigatewayv2_domain_name_security_policy }
    its('domain_name_configurations.first.ownership_verification_certificate_arn') { should be_empty }
  end

  describe aws_api_gateway_v2_domain_name(domain_name: aws_apigatewayv2_domain_name_domain_name) do
    its('api_gateway_domain_names') { should include aws_apigatewayv2_domain_name_target_domain_name }
    its('certificate_arns') { should include aws_apigatewayv2_domain_name_certificate_arn }
    its('certificate_names') { should_not be_empty }
    its('certificate_upload_dates') { should_not be_empty }
    its('domain_name_statuses') { should include 'AVAILABLE' }
    its('domain_name_status_messages') { should_not be_empty }
    its('endpoint_types') { should include aws_apigatewayv2_domain_name_endpoint_type }
    its('hosted_zone_ids') { should include aws_apigatewayv2_domain_name_hosted_zone_id }
    its('security_policies') { should include aws_apigatewayv2_domain_name_security_policy }
    its('ownership_verification_certificate_arns') { should_not be_empty }
  end
end
