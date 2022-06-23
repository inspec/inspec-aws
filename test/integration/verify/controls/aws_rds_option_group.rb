title 'Test single AWS Option Group'

aws_option_group_name= input(:aws_db_option_group_name, value: '', description: 'The AWS option group name.')
aws_db_option_group_engine_name= input(:aws_db_option_group_engine_name, value: '', description: '')
aws_db_option_group_description= input(:aws_db_option_group_description, value: '', description: '')

control 'aws-rds-option-groups-1.0' do
  impact 1.0
  title 'Ensure AWS RDS Option Groups has the correct properties.'
  
  describe aws_rds_option_group(option_group_name: aws_option_group_name ) do
    it { should exist }
    its('option_group_name')                           { should eq aws_option_group_name }
    its('engine_name')                                 { should eq aws_db_option_group_engine_name }
    its('option_group_description')                    { should eq aws_db_option_group_description }
    its('major_engine_version')                        { should eq '11.00' }
    its('option_group_arn')                            { should eq 'arn:aws:rds:us-east-2:112758395563:og:option-group-test-terraform2' }
    its('allows_vpc_and_non_vpc_instance_memberships') { should eq false }
  end
end


