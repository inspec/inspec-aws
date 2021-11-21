control 'aws-rds-db-proxy-endpoints-1.0' do
  impact 1.0
  title 'Test the properties of the rds db proxy endpoints.'

  describe aws_rds_db_proxy_endpoints(db_proxy_name: 'automate-pg-proxy') do
    it { should exist }
  end

  describe aws_rds_db_proxy_endpoints(db_proxy_name: 'automate-pg-proxy') do
    its('db_proxy_endpoint_names') { should include 'test-endpoint' }
    its('db_proxy_endpoint_arns') { should include 'arn:aws:rds:us-east-2:112758395563:db-proxy-endpoint:prx-endpoint-0f4a97fa5fdca3cc8' }
    its('db_proxy_names') { should include 'automate-pg-proxy' }
    its('statuses') { should include 'available' }
    its('vpc_ids') { should include 'vpc-6d9d7505' }
    its('vpc_security_group_ids') { should_not be_empty }
    its('vpc_subnet_ids') { should_not be_empty }
    its('endpoints') { should include 'test-endpoint.endpoint.proxy-cvjb1wur4wqf.us-east-2.rds.amazonaws.com' }
    its('created_dates') { should include Time.parse('2021-11-10 11:00:39.505000000 +0000') }
    its('target_roles') { should include 'READ_WRITE' }
    its('is_default') { should include false }
  end
end