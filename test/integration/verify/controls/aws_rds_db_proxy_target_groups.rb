control 'aws-rds-db-proxy-target-groups-1.0' do
  impact 1.0
  title 'Test the properties of the rds db proxy target groups.'

  describe aws_rds_db_proxy_target_groups(db_proxy_name: 'automate-pg-proxy') do
    it { should exist }
  end

  describe aws_rds_db_proxy_target_groups(db_proxy_name: 'automate-pg-proxy') do
    its('db_proxy_names') { should include 'automate-pg-proxy' }
    its('target_group_names') { should include 'default' }
    its('target_group_arns') { should include 'arn:aws:rds:us-east-2:112758395563:target-group:prx-tg-0baa0ada9ea055102' }
    its('is_default') { should include true }
    its('statuses') { should include 'available' }
    its('connection_pool_configs') { should_not be_empty }
    its('created_dates') { should include Time.parse('2021-01-05 16:22:20.960000000 +0000') }
    its('updated_dates') { should_not be_empty }
  end
end