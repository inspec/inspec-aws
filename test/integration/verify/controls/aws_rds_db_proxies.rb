aws_proxy_name = attribute(:aws_proxy_name, value: '')
control 'aws-rds-db-proxies-1.0' do
  impact 1.0
  title 'Test the properties of the rds db proxies.'

  describe aws_rds_db_proxies(db_proxy_name: 'automate-pg-proxy') do
    it { should exist }
  end

  describe aws_rds_db_proxies(db_proxy_name: 'automate-pg-proxy') do
    its('db_proxy_names') { should include 'automate-pg-proxy' }
    its('db_proxy_arns') { should include 'arn:aws:rds:us-east-2:112758395563:db-proxy:prx-0ec29b6fdc6515d9c' }
    its('statuses') { should include 'available' }
    its('engine_families') { should include 'POSTGRESQL' }
    its('vpc_ids') { should include 'vpc-6d9d7505' }
    its('vpc_security_group_ids') { should_not be_empty }
    its('vpc_subnet_ids') { should_not be_empty }

    its('auths') { should_not be_empty }

    its('role_arns') { should include 'arn:aws:iam::112758395563:role/service-role/rds-proxy-role-1609863739417' }
    its('endpoints') { should include 'automate-pg-proxy.proxy-cvjb1wur4wqf.us-east-2.rds.amazonaws.com' }
    its('require_tls') { should include false }
    its('idle_client_timeouts') { should include 1800 }
    its('debug_loggings') { should include false }
    its('created_dates') { should include Time.parse('2021-01-05 16:22:20.960000000 +0000') }
    its('updated_dates') { should include Time.parse('2021-11-10 11:04:50.434 UTC') }
  end
end