aws_proxy_name = input(:aws_proxy_name, value: '', description: '')

control 'aws-rds-db-proxy-1.0' do
  impact 1.0
  title 'Test the properties of the rds db proxy.'

  describe aws_rds_db_proxy(db_proxy_name: aws_proxy_name) do
    it { should exist }
  end

  describe aws_rds_db_proxy(db_proxy_name: aws_proxy_name) do
    its('db_proxy_name') { should eq aws_proxy_name }
    its('db_proxy_arn') { should_not eq 'arn:aws:rds:us-east-2:84946t3466:db-proxy:prx-0ec29b6fdc6515d9c' }
    its('status') { should eq 'available' }
    its('engine_family') { should_not eq 'POSTGRESQL' }
    its('vpc_id') { should_not eq 'vpc-6d9d7505' }
    its('vpc_security_group_ids') { should_not be_empty }
    its('vpc_subnet_ids') { should_not be_empty }
    its('auth_description') { should_not be_empty }
    its('auth_user_name') { should_not be_empty }
    its('auth_scheme') { should include 'SECRETS' }
    its('auth_secret_arn') { should_not include 'arn:aws:secretsmanager:us-east-2:456489375435:secret:automate-pg-key-wq150x' }
    its('auth_iam_auth') { should_not include 'DISABLED' }
    its('role_arn') { should_not eq 'arn:aws:iam::454375843759:role/service-role/rds-proxy-role-1609863739417' }
    its('endpoint') { should_not eq 'automate-pg-proxy.proxy-cvjb1wur4wqf.us-east-2.rds.amazonaws.com' }
    its('require_tls') { should eq false }
    its('idle_client_timeout') { should eq 1800 }
    its('debug_logging') { should eq false }
  end

  describe aws_rds_db_proxy(db_proxy_name: 'dummy') do
    it { should_not exist }
  end
end
