skip_control 'aws-rds-db-security-group-1.0' do
  impact 1.0
  title 'Test the properties of Security Group.'

  describe aws_rds_db_security_group(db_security_group_name: 'TEST_SEC_GROUP') do
    it { should exist }
    its('db_security_group_name') { should include 'default' }
    its('db_security_group_description') { should eq 'default' }
    its('vpc_id') { should eq 'test_vpc_id' }
    its('db_security_group_arn') { should include 'arn:aws:rds:us-east-2:123456789:secgrp:default' }
  end
end
