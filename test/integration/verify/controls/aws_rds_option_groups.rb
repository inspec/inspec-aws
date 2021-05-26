title 'Test single AWS Option Groups'

describe aws_rds_option_groups do
  it { should exist }
  its('option_group_names')                { should include 'option-group-test-terraform2' }
  its('engine_names')                      { should include 'sqlserver-ee' }
  its('option_group_description')          { should include 'Terraform Option Group' }
  its('major_engine_versions')             { should include '11.00' }
  its('option_group_arns')                 { should include "arn:aws:rds:us-east-2:112758395563:og:option-group-test-terraform2"}
  its('vpc_ids')                           { should include nil }
  its('allows_vpc_and_non_vpc_instance_memberships') { should include true }
end



