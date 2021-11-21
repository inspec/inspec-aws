control 'aws-rds-db-proxy-target-group-1.0' do
  impact 1.0
  title 'Test the properties of the rds db proxy target group.'

  describe aws_rds_db_proxy_target_group(db_proxy_name: 'automate-pg-proxy', target_group_name: 'default') do
    it { should exist }
  end

  describe aws_rds_db_proxy_target_group(db_proxy_name: 'automate-pg-proxy', target_group_name: 'default') do
    its('db_proxy_name') { should eq 'automate-pg-proxy' }
    its('target_group_name') { should eq 'default' }
    its('target_group_arn') { should eq 'arn:aws:rds:us-east-2:112758395563:target-group:prx-tg-0baa0ada9ea055102' }
    its('is_default') { should eq true }
    its('status') { should eq 'available' }
    its('connection_pool_config.max_connections_percent') { should eq 100 }
    its('connection_pool_config.max_idle_connections_percent') { should eq 50 }
    its('connection_pool_config.connection_borrow_timeout') { should eq 120 }
    its('connection_pool_config.session_pinning_filters') { should be_empty }
    its('connection_pool_config.init_query') { should include 'automate-pg-proxy' }
    its('created_date') { should eq Time.parse('2021-01-05 16:22:20.960000000 +0000') }
    its('updated_date') { should_not be_empty }
  end
end