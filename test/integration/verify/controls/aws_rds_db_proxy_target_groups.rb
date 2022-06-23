db_proxy_name = input(:aws_proxy_name, value: '', description: '')

control 'aws-rds-db-proxy-target-groups-1.0' do
  impact 1.0
  title 'Test the properties of the RDS DB Proxy Target Groups.'

  describe aws_rds_db_proxy_target_groups(db_proxy_name: db_proxy_name) do
    it { should exist }
  end

  describe aws_rds_db_proxy_target_groups(db_proxy_name: db_proxy_name) do
    its('db_proxy_names') { should include db_proxy_name }
    its('target_group_names') { should include 'default' }
    its('target_group_arns') { should_not include 'arn:aws:rds:us-east-2:1234567890:target-group:prx-tg-0baa0ada9ea055102' }
    its('is_default') { should include true }
    its('statuses') { should include 'available' }
    its('connection_pool_configs') { should_not be_empty }
  end

  describe aws_rds_db_proxy_target_groups(db_proxy_name: 'dummy') do
    it { should_not exist }
  end
end
