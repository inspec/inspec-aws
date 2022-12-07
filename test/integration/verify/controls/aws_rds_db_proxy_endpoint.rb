aws_proxy_name = input(:aws_proxy_name, value: '', description: '')
proxy_endpoint_name = input(:proxy_endpoint_name, value: '', description: '')

control 'aws-rds-db-proxy-endpoint-1.0' do
  impact 1.0
  title 'Test the properties of the rds db proxy endpoint.'

  describe aws_rds_db_proxy_endpoint(db_proxy_name: aws_proxy_name, db_proxy_endpoint_name: proxy_endpoint_name) do
    it { should exist }
  end

  describe aws_rds_db_proxy_endpoint(db_proxy_name: aws_proxy_name, db_proxy_endpoint_name: proxy_endpoint_name) do
    its('db_proxy_endpoint_name') { should eq proxy_endpoint_name }
    its('db_proxy_endpoint_arn') { should_not eq 'arn:aws:rds:us-east-2:47894300563:db-proxy-endpoint:prx-endpoint-0f4a97fa5fdca3cc8' }
    its('db_proxy_name') { should eq aws_proxy_name }
    its('status') { should eq 'available' }
    its('vpc_id') { should_not eq 'vpc-6d9d7505' }
    its('vpc_security_group_ids') { should_not be_empty }
    its('vpc_subnet_ids') { should_not be_empty }
    its('endpoint') { should_not eq 'test-endpoint.endpoint.proxy-cvjb1wur4wqf.us-east-2.rds.amazonaws.com' }
    its('target_role') { should_not eq 'READ_WRITE' }
    its('is_default') { should eq false }
  end

  describe aws_rds_db_proxy_endpoint(db_proxy_name: 'dummy', db_proxy_endpoint_name: 'dummy') do
    it { should_not exist }
  end
end
