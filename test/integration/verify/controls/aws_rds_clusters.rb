title 'Test multiple AWS RDS Clusters'

control 'aws-rds-clusters-1.0' do
  title 'Ensure AWS RDS Clusters has the correct properties.'

  describe aws_rds_clusters do
    it { should exist }
  end

  aws_rds_clusters.cluster_identifier.each do |cluster_identifier|
    describe aws_rds_cluster(cluster_identifier) do
      it { should have_encrypted_storage }
      it { should be_encrypted }
    end
  end
end
