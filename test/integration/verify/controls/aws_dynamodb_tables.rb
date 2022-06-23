title 'Test AWS DynamoDB Tables in bulk.'

aws_dynamodb_table_name = input(:aws_dynamodb_table_name, value: '', description: 'The AWS Dynamodb Table name.')

control 'aws-dynamodb-tables-1.0' do
  impact 1.0
  title 'Ensure AWS DynamoDB Table has current properties.'

  describe aws_dynamodb_tables do
    it { should exist }
  end

  aws_dynamodb_tables.where(table_names: aws_dynamodb_table_name).table_names.each do |table|
    describe aws_dynamodb_table(table_name: table) do
      it { should exist }
      it { should be_encrypted }
    end
  end

  describe aws_dynamodb_tables do
    its('table_names') { should include aws_dynamodb_table_name }
  end
end
