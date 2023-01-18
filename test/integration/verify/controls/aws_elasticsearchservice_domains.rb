aws_elasticsearch_domain_name = input(:aws_elasticsearch_domain_name, value: '', description: '')

control 'aws-elasticsearch-domains-1.0' do
  title 'Ensure AWS Elastic Search Domains has the correct properties.'

  describe aws_elasticsearchservice_domains do
    it { should exist }
  end

  describe aws_elasticsearchservice_domains do
    its('domain_names') { should include aws_elasticsearch_domain_name }
  end
end
