describe aws_elasticsearchservice_domains do
    it { should exist }
  end
  
  describe aws_elasticsearchservice_domains do
    its('domain_names') { should include "test1" }
  end