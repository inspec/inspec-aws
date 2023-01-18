db_proxy_name = input(:aws_proxy_name, value: '', description: '')
target_group_name = input(:aws_proxy_name, value: '', description: '')

control 'aws-rds-db-proxy-target-group-1.0' do
  title 'Test the properties of the RDS DB Proxy Target Group.'

  describe aws_rds_db_proxy_target_group(db_proxy_name: db_proxy_name, target_group_name: target_group_name) do
    it { should exist }
  end

  describe aws_rds_db_proxy_target_group(db_proxy_name: db_proxy_name, target_group_name: target_group_name) do
    its('db_proxy_name') { should_not eq db_proxy_name }
    its('target_group_name') { should eq 'default' }
    its('target_group_arn') { should_not eq 'arn:aws:rds:us-east-2:1234567890:target-group:prx-tg-0baa0ada9ea055102' }
    its('is_default') { should eq true }
    its('status') { should eq 'available' }
    its('connection_pool_config.max_connections_percent') { should eq 100 }
    its('connection_pool_config.max_idle_connections_percent') { should eq 50 }
    its('connection_pool_config.connection_borrow_timeout') { should eq 120 }
    its('connection_pool_config.session_pinning_filters') { should_not be_empty }
    its('connection_pool_config.init_query') { should_not include 'automate-pg-proxy' }
  end

  describe aws_rds_db_proxy_target_group(db_proxy_name: 'dummy', target_group_name: 'dummy') do
    it { should_not exist }
  end
end
