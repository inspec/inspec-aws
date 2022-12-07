skip_control 'aws-rds-db-security-groups-1.0' do
  impact 1.0
  title 'Test the properties of Security Groups.'

  describe aws_rds_db_security_groups do
    it { should exist }
    its('db_security_group_names') { should include 'default' }
    its('db_security_group_descriptions') { should include 'default' }
    its('vpc_ids') { should include 'test_vpc_id' }
    its('db_security_group_arns') { should include 'arn:aws:rds:us-east-2:123456789:secgrp:default' }
  end
end

