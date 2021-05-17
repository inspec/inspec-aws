describe aws_ecs_task_definition(task_definition: 'test1') do
    it { should exist }
end

describe aws_ecs_task_definition(task_definition: 'test1') do
    its("task_definition_arn") { should eq "arn:aws:ecs:us-east-2:112758395563:task-definition/test1:1" }
end

describe aws_ecs_task_definition(task_definition: 'test1') do
    its("container_definitions.first.name") { should eq "test1" }
    its("container_definitions.first.image") { should eq "test1" }


    its("container_definitions.first.repository_credentials.credentials_parameter") { should be_empty }
    its("container_definitions.first.cpu") { should eq 0 }
    its("container_definitions.first.memory") { should eq 11 }
    its("container_definitions.first.memory_reservation") { should be_empty }
    its("container_definitions.first.links") { should be_empty }
    its("container_definitions.first.port_mappings") { should be_empty }
    its("container_definitions.first.essential") { should eq true }
    its("container_definitions.first.image") { should eq "test1" }
    its("container_definitions.first.entry_point") { should be_empty }
    its("container_definitions.first.command") { should be_empty }
    its("container_definitions.first.environment") { should be_empty }
    its("container_definitions.first.mount_points") { should be_empty }
    its("container_definitions.first.volumes_from") { should be_empty }

    its("container_definitions.first.linux_parameters") { should be_empty }
    its("container_definitions.first.secrets") { should be_empty }
    its("container_definitions.first.depends_on") { should be_empty }
    its("container_definitions.first.start_timeout") { should be_empty }
    its("container_definitions.first.stop_timeout") { should be_empty }
    its("container_definitions.first.hostname") { should be_empty }
    its("container_definitions.first.user") { should be_empty }
    its("container_definitions.first.working_directory") { should be_empty }
    its("container_definitions.first.disable_networking") { should be_empty }
    its("container_definitions.first.privileged") { should be_empty }
    its("container_definitions.first.readonly_root_filesystem") { should be_empty }
    its("container_definitions.first.dns_servers") { should be_empty }
    its("container_definitions.first.dns_search_domains") { should be_empty }
    its("container_definitions.first.extra_hosts") { should be_empty }
    its("container_definitions.first.docker_security_options") { should be_empty }
    its("container_definitions.first.interactive") { should be_empty }
    its("container_definitions.first.pseudo_terminal") { should be_empty }
    its("container_definitions.first.docker_labels") { should be_empty }
    its("container_definitions.first.ulimits") { should be_empty }
    its("container_definitions.first.log_configuration") { should be_empty }
    its("container_definitions.first.health_check") { should be_empty }
    its("container_definitions.first.system_controls") { should be_empty }
    its("container_definitions.first.resource_requirements") { should be_empty }
    its("container_definitions.first.firelens_configuration") { should be_empty }


    its("family") { should eq "test1" }
    its("task_role_arn") { should be_empty }
    its("execution_role_arn") { should be_empty }
    its("network_mode") { should be_empty }
    its("revision") { should eq 1 }
    its("volumes") { should be_empty }
    its("status") { should eq "ACTIVE" }
    its("requires_attributes") { should be_empty }
    its("placement_constraints") { should be_empty }
    its("compatibilities") { should include "EC2" }
    its("requires_compatibilities") { should include "EC2" }
    its("cpu") { should be_empty }
    its("memory") { should be_empty }
    its("inference_accelerators") { should be_empty }
    its("pid_mode") { should be_empty }
    its("ipc_mode") { should be_empty }
    its("proxy_configuration") { should be_empty }
    its("registered_at") { should_not be_empty }
    its("deregistered_at") { should be_empty }
    its("registered_by") { should eq "arn:aws:sts::112758395563:assumed-role/Okta_AdministratorAccess/skarmaka" }
    its("ephemeral_storage") { should be_empty }
end