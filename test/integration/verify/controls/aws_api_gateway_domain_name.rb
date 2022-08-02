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

control 'aws-api-gateway-domain-name-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway domain name.'
  
  describe aws_api_gateway_domain_name(domain_name: aws_api_gateway_domain_name) do
    it { should exist }
  end
  
  describe aws_api_gateway_domain_name(domain_name: aws_api_gateway_domain_name) do
    its ('domain_name') { should eq aws_api_gateway_domain_name }
    its ('certificate_name') { should be_empty }
    its ('certificate_arn') { should eq aws_api_gateway_certificate_arn }
    its ('certificate_upload_date') { should eq aws_api_gateway_certificate_upload_date }
    its ('regional_domain_name') { should be_empty }
    its ('regional_hosted_zone_id') { should be_empty }
    its ('regional_certificate_name') { should be_empty }
    its ('regional_certificate_arn') { should be_empty }
    its ('distribution_domain_name') { should eq aws_api_gateway_distribution_domain_name }
    its ('distribution_hosted_zone_id') { should eq aws_api_gateway_distribution_hosted_zone_id }
    its ('endpoint_configuration.types') { should eq ["EDGE"] }
    its ('endpoint_configuration.vpc_endpoint_ids') { should be_empty }
    its ('domain_name_status') { should eq aws_api_gateway_domain_name_status }
    its ('domain_name_status_message') { should be_empty }
    its ('security_policy') { should eq aws_api_gateway_security_policy }
    its ('tags') { should be_empty }
    its ('mutual_tls_authentication.truststore_uri') { should be_empty }
    its ('mutual_tls_authentication.truststore_version') { should be_empty }
    its ('mutual_tls_authentication.truststore_warnings') { should be_empty }
    its ('ownership_verification_certificate_arn') { should be_empty }
  end
  
  describe aws_api_gateway_domain_name(domain_name: aws_api_gateway_domain_name) do
    its ('endpoint_configuration_types') { should be_empty }
    its ('endpoint_configuration_vpc_endpoint_ids') { should be_empty }
    its ('mutual_tls_authentication_truststore_warnings') { should be_empty }
  end
end
