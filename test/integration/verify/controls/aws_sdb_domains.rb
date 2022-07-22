title 'Test AWS SimpleDB Domains'

domain_names_sdb = input(:domain_names_sdb , value: '', description: '')

control 'aws-sdb-domains-1.0' do
  impact 1.0
  title 'Ensure AWS Simple DB.'
  
  describe aws_sdb_domains do
    it { should exist }
    its('domain_names') { should include domain_names_sdb }
  end
end
