describe aws_ecs_task_definition(task_definition: 'test1:1') do
    it { should exist }
  end

describe aws_ecs_task_definition(task_definition: 'test1:1') do
    its('task_definition_arn') { should eq 'arn:aws:ecs:us-east-2:112758395563:task-definition/test1:1' }
    its('container_definitions.first.name') { should eq 'test1' }
    its('container_definitions.first.image') { should eq 'test1' }
    its('container_definitions.first.repository_credentials.credentials_parameter') { should be_empty }
    its('container_definitions.first.cpu') { should eq 0 }
    its('container_definitions.first.memory') { should eq 11 }
    its('container_definitions.first.memory_reservation') { should be_empty }
    its('container_definitions.first.links') { should be_empty }
    its('container_definitions.first.port_mappings') { should be_empty }
    its('container_definitions.first.essential') { should eq true }
    its('container_definitions.first.entry_point') { should be_empty }
    its('container_definitions.first.command') { should be_empty }
    its('container_definitions.first.environment') { should be_empty }
    its('container_definitions.first.environment_files') { should be_empty }
    its('container_definitions.first.mount_points') { should be_empty }
    its('container_definitions.first.volumes_from') { should be_empty }
    its('container_definitions.first.linux_parameters.capabilities.ad') { should be_empty }
    its('container_definitions.first.linux_parameters.capabilities.drop') { should be_empty }
    its('container_definitions.first.linux_parameters.devices') { should be_empty }
    its('container_definitions.first.linux_parameters.devices.first.host_path') { should be_empty }
    its('container_definitions.first.linux_parameters.devices.first.container_path') { should be_empty }
    its('container_definitions.first.linux_parameters.devices.first.permissions') { should be_empty }
    its('container_definitions.first.linux_parameters.init_process_enabled') { should be_empty }
    its('container_definitions.first.linux_parameters.shared_memory_size') { should be_empty }
    its('container_definitions.first.linux_parameters.tmpfs') { should be_empty }
    its('container_definitions.first.linux_parameters.tmpfs.first.container_path') { should be_empty }
    its('container_definitions.first.linux_parameters.tmpfs.first.size') { should be_empty }
    its('container_definitions.first.linux_parameters.tmpfs.first.mount_options') { should be_empty }
    its('container_definitions.first.linux_parameters.max_swap') { should be_empty }
    its('container_definitions.first.linux_parameters.swappiness') { should be_empty }
    its('container_definitions.first.secrets') { should be_empty }
    its('container_definitions.first.secrets.first.name') { should be_empty }
    its('container_definitions.first.secrets.first.value_from') { should be_empty }
    its('container_definitions.first.depends_on') { should be_empty }
    its('container_definitions.first.depends_on.first.container_name') { should be_empty }
    its('container_definitions.first.depends_on.first.condition') { should be_empty }
    its('container_definitions.first.start_timeout') { should be_empty }
    its('container_definitions.first.stop_timeout') { should be_empty }
    its('container_definitions.first.hostname') { should be_empty }
    its('container_definitions.first.user') { should be_empty }
    its('container_definitions.first.working_directory') { should be_empty }
    its('container_definitions.first.disable_networking') { should be_empty }
    its('container_definitions.first.privileged') { should be_empty }
    its('container_definitions.first.readonly_root_filesystem') { should be_empty }
    its('container_definitions.first.dns_servers') { should be_empty }
    its('container_definitions.first.dns_search_domains') { should be_empty }
    its('container_definitions.first.extra_hosts') { should be_empty }
    its('container_definitions.first.extra_hosts.first.hostname') { should be_empty }
    its('container_definitions.first.extra_hosts.first.ip_address') { should be_empty }
    its('container_definitions.first.docker_security_options') { should be_empty }
    its('container_definitions.first.interactive') { should be_empty }
    its('container_definitions.first.pseudo_terminal') { should be_empty }
    its('container_definitions.first.docker_labels') { should be_empty }
    its('container_definitions.first.ulimits') { should be_empty }
    its('container_definitions.first.ulimits.first.name') { should be_empty }
    its('container_definitions.first.ulimits.first.soft_limit') { should be_empty }
    its('container_definitions.first.ulimits.first.hard_limit') { should be_empty }
    its('container_definitions.first.log_configuration.log_driver') { should be_empty }
    its('container_definitions.first.log_configuration.options') { should be_empty }
    its('container_definitions.first.log_configuration.secret_options') { should be_empty }
    its('container_definitions.first.log_configuration.secret_options.first.name') { should be_empty }
    its('container_definitions.first.log_configuration.secret_options.first.value_from') { should be_empty }
    its('container_definitions.first.health_check.command') { should be_empty }
    its('container_definitions.first.health_check.interval') { should be_empty }
    # its('container_definitions.first.health_check.timeout') { should_not be_empty }
    its('container_definitions.first.health_check.retries') { should be_empty }
    its('container_definitions.first.health_check.start_period') { should be_empty }
    its('container_definitions.first.system_controls') { should be_empty }
    its('container_definitions.first.system_controls.first.namespace') { should be_empty }
    its('container_definitions.first.system_controls.first.value') { should be_empty }
    its('container_definitions.first.resource_requirements') { should be_empty }
    its('container_definitions.first.resource_requirements.first.value') { should be_empty }
    its('container_definitions.first.resource_requirements.first.type') { should be_empty }
    its('container_definitions.first.firelens_configuration.type') { should be_empty }
    its('container_definitions.first.firelens_configuration.options') { should be_empty }

    its('family') { should eq 'test1' }
    its('task_role_arn') { should be_empty }
    its('execution_role_arn') { should be_empty }
    its('network_mode') { should be_empty }
    its('revision') { should eq 1 }
    its('volumes') { should be_empty }
    its('status') { should eq 'ACTIVE' }
    its('requires_attributes') { should be_empty } 
    its('requires_attributes.first.name') { should be_empty } 
    its('requires_attributes.first.value') { should be_empty }
    its('requires_attributes.first.target_type') { should be_empty }
    its('requires_attributes.first.target') { should be_empty }
    its('placement_constraints') { should be_empty }
    its('compatibilities') { should include "EC2" }
    its('requires_compatibilities') { should include "EC2" }

    its('cpu') { should be_empty }
    its('memory') { should be_empty }
    its('inference_accelerators') { should be_empty }
    its('inference_accelerators.first.device_name') { should be_empty }
    its('inference_accelerators.first.device_type') { should be_empty }
    its('pid_mode') { should be_empty }
    its('ipc_mode') { should be_empty }
    its('proxy_configuration.type') { should be_empty }
    its('proxy_configuration.container_name') { should be_empty }
    its('proxy_configuration.properties') { should be_empty }
    its('proxy_configuration.properties.first.name') { should be_empty }
    its('proxy_configuration.properties.first.value') { should be_empty }
    its('tags') { should be_empty }
end