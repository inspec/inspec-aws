control 'aws-endpoints-1.0' do
  title 'Ensure AWS DMS Endpoints has the correct properties.'

  describe aws_dms_endpoints do
    it { should exist }
  end

  describe aws_dms_endpoints do
    its('endpoint_identifiers') { should include 'test1' }
    its('endpoint_types') { should include 'SOURCE' }
    its('engine_names') { should include 'aurora' }
    its('engine_display_names') { should include 'Amazon Aurora MySQL' }
    its('ports') { should include 3306 }
  end
end
