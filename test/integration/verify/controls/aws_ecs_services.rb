aws_cluster_names = input(:aws_cluster_name, value: '', description: '')
aws_service_arn = input( :aws_service_id, value: '', description: '')
aws_service_name = input(:aws_ecs_service_name, value: '', description: '')
aws_cluster_arn = input(:aws_cluster_arn, value: '', description: '')

control 'aws-ecs-services-1.0' do
  title 'Ensure AWS ECS Services has the correct properties.'

  describe aws_ecs_services(cluster: aws_cluster_names) do
    it { should exist }
  end

  describe aws_ecs_services(cluster: aws_cluster_names) do
    its('service_names') { should include aws_service_name }
    its('service_arns') { should include aws_service_arn }
    its('cluster_arns') { should include aws_cluster_arn}
    its('status') { should include 'ACTIVE' }
    its('desired_count') { should include 0 }
    its('pending_count') { should include 0 }
    its('launch_types') { should include 'EC2' }
  end
end
