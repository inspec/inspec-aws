aws_emr_cluster_id = attribute(:aws_emr_cluster_id, value: '', description: 'AWS EMR cluster ID.')

title 'Test single AWS EMR Cluster'

control 'aws-emr-cluster-1.0' do
  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    it { should exist }
  end

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    it { should_not be_running }
  end
  
  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    it { should be_waiting }
  end

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    its('encryption_at_rest') { should eq true }
  end

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    its('encryption_in_transit') { should eq false }
  end

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    its('local_disk_encryption') { should eq true }
  end
end
