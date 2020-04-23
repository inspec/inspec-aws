title 'Test multiple AWS ElastiCache Clusters'

control 'aws-elasti-cache-clusters-1.0' do

  impact 1.0
  title 'Ensure AWS ElastiCache Clusters have the correct properties.'

  describe aws_elasti_cache_clusters do
    it { should exist }
    its('count') { should be >= 1 }
  end
end
