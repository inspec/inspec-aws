control 'aws-glue-database-1.0' do
  title 'Ensure AWS Glue Database singular resource have the correct properties.'

  describe aws_glue_database(name: 'sampledb') do
    it { should exist }
  end
  
  describe aws_glue_database(name: 'sampledb') do
    its('name') { should eq 'sampledb' }
    its('description') { should eq 'Sample description' }
    its('location_uri') { should be_empty }
    its('parameters') { should be_empty }
    its('create_table_default_permissions') { should_not be_empty }
    its('create_table_default_permissions.first.principal.data_lake_principal_identifier') { should eq 'IAM_ALLOWED_PRINCIPALS' }
    its('create_table_default_permissions.first.permissions') { should include 'ALL' }
    its('target_database.catalog_id') { should be_empty }
    its('target_database.database_name') { should be_empty }
    its('catalog_id') { should_not eq '112758395563' }
  end
end
