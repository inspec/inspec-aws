title 'Test a collection of AWS ECS Clusters'

aws_ecs_cluster_name = input(:aws_ecs_cluster_name, value: '', description: 'The ECS Cluster name.')

control 'aws-ecs-clusters-1.0' do
  title 'Ensure AWS ECS Cluster plural resource has the correct properties.'

  describe aws_ecs_clusters do
    it                   { should exist }
    its('cluster_names') { should include aws_ecs_cluster_name }
    its('statuses')      { should_not include 'UNDESIRED-STATUS'}
  end
end
