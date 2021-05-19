describe aws_glue_databases do
    it { should exist }
  end
  
  describe aws_glue_databases do
    its('names') { should include 'sampledb' }
    its('descriptions') { should include 'Sample database' }
    its('location_uris') { should_not be_empty }
    its('parameters') { should_not be_empty }
    its('create_times') { should_not be_empty }
    its('create_table_default_permissions') { should_not be_empty }
    its('target_databases') { should_not be_empty }
    its('catalog_ids') { should include '112758395563' }
  end
  
  