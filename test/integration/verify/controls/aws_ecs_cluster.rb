title 'Test single AWS ECS Cluster'

aws_ecs_cluster_name = input(:aws_ecs_cluster_name, value: '', description: 'The AWS ECS Cluster name.')

control 'aws-ecs-cluster-1.0' do
  impact 1.0
  title 'Ensure AWS ECS Cluster has the correct properties.'

  describe aws_ecs_cluster(cluster_name: aws_ecs_cluster_name) do
    it              { should exist }
    its ('status')  { should eq 'ACTIVE' }
  end
end