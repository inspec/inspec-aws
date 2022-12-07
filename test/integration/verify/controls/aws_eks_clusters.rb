title 'Test a collection of AWS EKS Clusters'

cluster_name = input(:aws_eks_cluster_name, value: '', description: 'The AWS EKS Cluster name.')

control 'aws-eks-clusters-1.0' do
  impact 1.0
  title 'Ensure AWS EKS Clusters have the correct properties.'

  describe aws_eks_clusters do
    it                    { should exist }
    its ('names')         { should include cluster_name}
  end
end
