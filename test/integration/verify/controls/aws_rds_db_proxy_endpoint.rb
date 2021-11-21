control 'aws-rds-db-proxy-endpoint-1.0' do
  impact 1.0
  title 'Test the properties of the rds db proxy endpoint.'

  describe aws_rds_db_proxy_endpoint(db_proxy_name: 'automate-pg-proxy', db_proxy_endpoint_name: 'test-endpoint') do
    it { should exist }
  end

  describe aws_rds_db_proxy_endpoint(db_proxy_name: 'automate-pg-proxy', db_proxy_endpoint_name: 'test-endpoint') do
    its('db_proxy_endpoint_name') { should eq 'test-endpoint' }
    its('db_proxy_endpoint_arn') { should eq 'arn:aws:rds:us-east-2:112758395563:db-proxy-endpoint:prx-endpoint-0f4a97fa5fdca3cc8' }
    its('db_proxy_name') { should eq 'automate-pg-proxy' }
    its('status') { should eq 'available' }
    its('vpc_id') { should eq 'vpc-6d9d7505' }
    its('vpc_security_group_ids') { should_not be_empty }
    its('vpc_subnet_ids') { should_not be_empty }
    its('endpoint') { should eq 'test-endpoint.endpoint.proxy-cvjb1wur4wqf.us-east-2.rds.amazonaws.com' }
    its('created_date') { should eq Time.parse('2021-11-10 11:00:39.505000000 +0000') }
    its('target_role') { should eq 'READ_WRITE' }
    its('is_default') { should eq false }
  end
end