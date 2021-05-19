title 'Test single AWS Option Group'

aws_option_group_name= attribute(:aws_option_group_name, default: '', description: 'The AWS option group name.')

describe aws_rds_group_option(option_group_name: aws_option_group_name) do
  it { should exist }
  its('option_group_name')                { should eq 'doption-group-test-terraform' }
  its('engine_name')                      { should eq 'sqlserver-ee' }
  its('option_group_description')         { should eq 'Terraform Option Group' }
  its('major_engine_version')             { should eq '11.00' }
  its('option_group_arn')                 { should eq 'IAM_ROLE_ARN_Valueq' }
  its('vpc_id')                           { should eq nil }
  its('allows_vpc_and_non_vpc_instance_memberships') { should eq true }
end

