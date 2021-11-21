title 'Test single AWS Option Groups'

aws_option_group_name= attribute(:aws_db_option_group_name, value: '', description: 'The AWS option group name.')
aws_db_option_group_engine_name= attribute(:aws_db_option_group_engine_name, value: '', description: 'The AWS option group name.')
aws_db_option_group_description= attribute(:aws_db_option_group_description, value: '', description: 'The AWS option group name.')


describe aws_rds_option_groups do
  it { should exist }
  its('option_group_names')                { should include aws_option_group_name }
  its('engine_names')                      { should include aws_db_option_group_engine_name }
  its('option_group_description')          { should include aws_db_option_group_description }
  its('major_engine_versions')             { should include '11.00' }
  its('option_group_arns')                 { should include "arn:aws:rds:us-east-2:112758395563:og:option-group-test-terraform2"}
  its('vpc_ids')                           { should include nil }
  its('allows_vpc_and_non_vpc_instance_memberships') { should include true }
end



