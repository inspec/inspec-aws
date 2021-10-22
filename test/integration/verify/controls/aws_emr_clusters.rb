aws_emr_cluster_id = attribute(:aws_emr_cluster_id, value: '', description: 'AWS EMR cluster ID.')

title 'Test single AWS EMR Cluster in bulk'

control 'aws-emr-clusters-1.0' do
  describe aws_emr_clusters do
    it { should exist }
    its('cluster_ids') { should include aws_emr_cluster_id}
  end
end
