title 'Test a single AWS EKS Cluster'

cluster_name = input(:aws_eks_cluster_name, value: '', description: 'The AWS EKS Cluster name.')

control 'aws-eks-cluster-1.0' do
  impact 1.0
  title 'Ensure AWS EKS Cluster has the correct properties.'

  describe aws_eks_cluster(cluster_name: cluster_name) do
    it           { should exist }
    its ('name') { should eq cluster_name}
  end
end
