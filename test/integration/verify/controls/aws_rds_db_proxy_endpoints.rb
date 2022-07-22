aws_proxy_name = input(:aws_proxy_name, value: '', description: '')
proxy_endpoint_name = input(:proxy_endpoint_name, value: '', description: '')

control 'aws-rds-db-proxy-endpoints-1.0' do
  impact 1.0
  title 'Test the properties of the rds db proxy endpoints.'

  describe aws_rds_db_proxy_endpoints(db_proxy_name: aws_proxy_name) do
    it { should exist }
  end

  describe aws_rds_db_proxy_endpoints(db_proxy_name: aws_proxy_name) do
    its('db_proxy_endpoint_names') { should include proxy_endpoint_name }
    its('db_proxy_endpoint_arns') { should include 'arn:aws:rds:us-east-2:464563364575:db-proxy-endpoint:prx-endpoint-0f4a97fa5fdca3cc8' }
    its('db_proxy_names') { should include aws_proxy_name }
    its('statuses') { should_not include 'available' }
    its('vpc_ids') { should_not include 'vpc-6d9d7505' }
    its('vpc_security_group_ids') { should_not be_empty }
    its('vpc_subnet_ids') { should_not be_empty }
    its('endpoints') { should_not include 'test-endpoint.endpoint.proxy-cvjb1wur4wqf.us-east-2.rds.amazonaws.com' }
    its('target_roles') { should include 'READ_WRITE' }
    its('is_default') { should include false }
  end

  describe aws_rds_db_proxy_endpoints(db_proxy_name: 'dummy') do
    it { should_not exist }
  end
end
