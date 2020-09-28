title 'Test AWS DynamoDB Tables in bulk'

control 'aws-dynamodb-tables-1.0' do

  impact 1.0
  title 'Ensure AWS DynamoDB Table has current properties'

  describe aws_dynamodb_tables do
    it { should exist }
  end

  aws_dynamodb_tables.table_names.each do |table|
    describe aws_dynamodb_table(table_name: table) do
      it { should exist }
      it { should be_encrypted }
    end
  end
end
