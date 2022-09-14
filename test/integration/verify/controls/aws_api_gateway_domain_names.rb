aws_api_gateway_domain_name = input(:aws_api_gateway_domain_name, value: '', description: '')
aws_api_gateway_certificate_name = input(:aws_api_gateway_certificate_name, value: '', description: '')
aws_api_gateway_certificate_arn = input(:aws_api_gateway_certificate_arn, value: '', description: '')
aws_api_gateway_certificate_upload_date = input(:aws_api_gateway_certificate_upload_date, value: '', description: '')
aws_api_gateway_regional_domain_name = input(:aws_api_gateway_regional_domain_name, value: '', description: '')
aws_api_gateway_regional_hosted_zone_id = input(:aws_api_gateway_regional_hosted_zone_id, value: '', description: '')
aws_api_gateway_regional_certificate_name = input(:aws_api_gateway_regional_certificate_name, value: '', description: '')
aws_api_gateway_regional_certificate_arn = input(:aws_api_gateway_regional_certificate_arn, value: '', description: '')
aws_api_gateway_distribution_domain_name = input(:aws_api_gateway_distribution_domain_name, value: '', description: '')
aws_api_gateway_distribution_hosted_zone_id = input(:aws_api_gateway_distribution_hosted_zone_id, value: '', description: '')
aws_api_gateway_domain_name_status = input(:aws_api_gateway_domain_name_status, value: 'AVAILABLE', description: '')
aws_api_gateway_domain_name_status_message = input(:aws_api_gateway_domain_name_status_message, value: '', description: '')
aws_api_gateway_security_policy = input(:aws_api_gateway_security_policy, value: 'TLS_1_2', description: '')

control 'aws-api-gateway-domain-names-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway domain names.'
  
  describe aws_api_gateway_domain_names do
    it { should exist }
  end
  
  describe aws_api_gateway_domain_names do
    its ('domain_names') { should include aws_api_gateway_domain_name }
    its ('certificate_names') { should be_empty }
    its ('certificate_arns') { should include aws_api_gateway_certificate_arn }
    its ('certificate_upload_dates') { should include aws_api_gateway_certificate_upload_date }
    its ('regional_domain_names') { should be_empty }
    its ('regional_hosted_zone_ids') { should be_empty }
    its ('regional_certificate_names') { should be_empty }
    its ('regional_certificate_arns') { should be_empty }
    its ('distribution_domain_names') { should include aws_api_gateway_distribution_domain_name }
    its ('distribution_hosted_zone_ids') { should include aws_api_gateway_distribution_hosted_zone_id }
    its ('endpoint_configurations') { should_not be_empty }
    its ('domain_name_statuses') { should include aws_api_gateway_domain_name_status }
    its ('domain_name_status_messages') { should be_empty }
    its ('security_policies') { should include aws_api_gateway_security_policy }
    its ('tags') { should be_empty }
    its ('mutual_tls_authentications') { should be_empty }
    its ('ownership_verification_certificate_arns') { should be_empty }
  end
end
