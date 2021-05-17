describe aws_ecs_service(cluster: "test1", services: ["arn:aws:ecs:us-east-2:112758395563:service/test1/service2"]) do
    it { should exist }
  end

describe aws_ecs_service(cluster: "test1", services: ["arn:aws:ecs:us-east-2:112758395563:service/test1/service2"]) do
    its('service_arn') { should eq "arn:aws:ecs:us-east-2:112758395563:service/test1/service2" }
    its('service_name') { should eq "service2" }
    its('cluster_arn') { should eq "arn:aws:ecs:us-east-2:112758395563:cluster/test1" }
    its('load_balancers') { should be_empty }
    its('service_registries') { should be_empty }
    its('status') { should eq "ACTIVE" }
    its('desired_count') { should eq 10 }
    its('running_count') { should eq 0 }
    its('pending_count') { should eq 0 }
    its('launch_type') { should eq "EC2" }
    its('capacity_provider_strategy') { should be_empty }
    its('capacity_provider_strategy.first.capacity_provider') { should be_empty }
    its('capacity_provider_strategy.first.weight') { should be_empty }
    its('capacity_provider_strategy.first.base') { should be_empty }
    its('platform_version') { should be_empty }
    its('task_definition') { should eq "arn:aws:ecs:us-east-2:112758395563:task-definition/test1:2" }
    its('deployment_configuration.maximum_percent') { should eq 200 }
    its('deployment_configuration.minimum_healthy_percent') { should eq 100 }
    its('task_sets') { should be_empty }
    its('deployments') { should_not be_empty }
    its('deployments.first.id') { should eq "ecs-svc/6728664169622343965" }
    its('deployments.first.status') { should eq "PRIMARY" }
    its('deployments.first.task_definition') { should eq "arn:aws:ecs:us-east-2:112758395563:task-definition/test1:2" }
    its('deployments.first.desired_count') { should eq 10}
    its('deployments.first.pending_count') { should eq 0 }
    its('deployments.first.running_count') { should eq 0 }
    # its('deployments.first.created_at') { should eq "" }
    # its('deployments.first.updated_at') { should eq "" }
    its('deployments.first.capacity_provider_strategy') { should be_empty }
    its('deployments.first.capacity_provider_strategy.first.capacity_provider') { should be_empty }
    its('deployments.first.capacity_provider_strategy.first.weight') { should be_empty }
    its('deployments.first.capacity_provider_strategy.first.base') { should be_empty }
    its('deployments.first.launch_type') { should eq "EC2" }
    its('deployments.first.platform_version') { should be_empty }
    its('deployments.first.network_configuration.awsvpc_configuration.subnets') { should be_empty }
    its('deployments.first.network_configuration.awsvpc_configuration.subnets.first') { should be_empty }
    its('deployments.first.network_configuration.awsvpc_configuration.security_groups') { should be_empty }
    its('deployments.first.network_configuration.awsvpc_configuration.assign_public_ip') { should be_empty }
    its('role_arn') { should be_empty }
    its('events') { should_not be_empty }
    its('health_check_grace_period_seconds') { should be_empty }
    its('scheduling_strategy') { should eq "REPLICA" }
    its('deployment_controller.type') { should be_empty }
    its('tags') { should be_empty }
    its('created_by') { should eq "arn:aws:iam::112758395563:role/Okta_AdministratorAccess" }
    its('enable_ecs_managed_tags') { should be true }
    its('propagate_tags') { should_not be_empty }
end