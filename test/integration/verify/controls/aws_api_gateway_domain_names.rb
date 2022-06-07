aws_api_gateway_domain_name = attribute(:aws_api_gateway_domain_name, value: 'test.eng.chefdemo.net', description: '')
aws_api_gateway_certificate_name = attribute(:aws_api_gateway_certificate_name, value: '', description: '')
aws_api_gateway_certificate_arn = attribute(:aws_api_gateway_certificate_arn, value: 'arn:aws:acm:us-east-1:112758395563:certificate/f3ef5702-c193-44d0-9a1f-a925dd3cd51b', description: '')
aws_api_gateway_certificate_upload_date = attribute(:aws_api_gateway_certificate_upload_date, value: Time.parse('2021-09-20 12:50:03.000000000 +0530'), description: '')
aws_api_gateway_regional_domain_name = attribute(:aws_api_gateway_regional_domain_name, value: '', description: '')
aws_api_gateway_regional_hosted_zone_id = attribute(:aws_api_gateway_regional_hosted_zone_id, value: 'Z2FDTNDATAQYW2', description: '')
aws_api_gateway_regional_certificate_name = attribute(:aws_api_gateway_regional_certificate_name, value: '', description: '')
aws_api_gateway_regional_certificate_arn = attribute(:aws_api_gateway_regional_certificate_arn, value: '', description: '')
aws_api_gateway_distribution_domain_name = attribute(:aws_api_gateway_distribution_domain_name, value: 'd3c6scbt02xz6x.cloudfront.net', description: '')
aws_api_gateway_distribution_hosted_zone_id = attribute(:aws_api_gateway_distribution_hosted_zone_id, value: 'Z2FDTNDATAQYW2', description: '')
aws_api_gateway_domain_name_status = attribute(:aws_api_gateway_domain_name_status, value: 'AVAILABLE', description: '')
aws_api_gateway_domain_name_status_message = attribute(:aws_api_gateway_domain_name_status_message, value: '', description: '')
aws_api_gateway_security_policy = attribute(:aws_api_gateway_security_policy, value: 'TLS_1_2', description: '')

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
