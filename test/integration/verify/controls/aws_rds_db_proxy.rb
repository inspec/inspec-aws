aws_proxy_name = attribute(:aws_proxy_name, value: '')
control 'aws-rds-db-proxy-1.0' do
  impact 1.0
  title 'Test the properties of the rds db proxy.'

  describe aws_rds_db_proxy(db_proxy_name: 'automate-pg-proxy') do
    it { should exist }
  end

  describe aws_rds_db_proxy(db_proxy_name: 'automate-pg-proxy') do
    its('db_proxy_name') { should eq 'automate-pg-proxy' }
    its('db_proxy_arn') { should eq 'arn:aws:rds:us-east-2:112758395563:db-proxy:prx-0ec29b6fdc6515d9c' }
    its('status') { should eq 'available' }
    its('engine_family') { should eq 'POSTGRESQL' }
    its('vpc_id') { should eq 'vpc-6d9d7505' }
    its('vpc_security_group_ids') { should_not be_empty }
    its('vpc_subnet_ids') { should_not be_empty }

    its('auth_description') { should_not be_empty }
    its('auth_user_name') { should_not be_empty }
    its('auth_scheme') { should include 'SECRETS' }
    its('auth_secret_arn') { should include 'arn:aws:secretsmanager:us-east-2:112758395563:secret:automate-pg-key-wq150x' }
    its('auth_iam_auth') { should include 'DISABLED' }

    its('role_arn') { should eq 'arn:aws:iam::112758395563:role/service-role/rds-proxy-role-1609863739417' }
    its('endpoint') { should eq 'automate-pg-proxy.proxy-cvjb1wur4wqf.us-east-2.rds.amazonaws.com' }
    its('require_tls') { should eq false }
    its('idle_client_timeout') { should eq 1800 }
    its('debug_logging') { should eq false }
    its('created_date') { should eq Time.parse('2021-01-05 16:22:20.960000000 +0000') }
    its('updated_date') { should eq Time.parse('2021-11-10 11:04:50.434 UTC') }
  end
end