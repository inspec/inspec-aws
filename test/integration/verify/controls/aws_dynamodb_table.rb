title 'Test single AWS CloudWatch Alarm'

aws_dynamodb_table_name = input(:aws_dynamodb_table_name, value: '', description: 'The AWS Dynamodb Table name.')
aws_dynamodb_table_arn = input(:aws_dynamodb_table_arn, value: '', description: 'The AWS Dynamodb Table arn.')

control 'aws-dynamodb-table-1.0' do

  impact 1.0
  title 'Ensure AWS Dynamodb Table has the correct properties.'

  describe aws_dynamodb_table(table_name: aws_dynamodb_table_name) do
    it { should exist }
    its('table_name')                    { should eq aws_dynamodb_table_name }
    its('table_arn')                     { should eq aws_dynamodb_table_arn }
    its('table_status')                  { should eq 'ACTIVE' }
    its('creation_date')                 { should be > '01/01/2019' }
    its('number_of_decreases_today')     { should cmp 0 }
    its('write_capacity_units')          { should cmp 20 }
    its('read_capacity_units')           { should cmp 20 }
    its('item_count')                    { should cmp 0 }
    its('attributes')                    { should include({:attribute_name =>'Score', :attribute_type =>'N'}) }
    its('attributes')                    { should include({:attribute_name =>'Title', :attribute_type =>'S'}) }
    its('attributes')                    { should include({:attribute_name =>'UserId', :attribute_type =>'S'}) }
    its('key_schema')                    { should include({:attribute_name =>'UserId', :key_type =>'HASH'}) }
    its('key_schema')                    { should include({:attribute_name =>'Title', :key_type =>'RANGE'}) }
    its('global_sec_indexes_index_name') { should eq 'TitleIndex' }
  end

  describe aws_dynamodb_table(table_name: 'NotThere') do
    it { should_not exist }
  end

end