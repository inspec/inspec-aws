aws_ecs_task_definition_arn = input(:aws_ecs_task_definition_arn, value: '', description: '')
aws_ecs_task_definition_revision = input(:aws_ecs_task_definition_revision, value: '', description: '')

control 'aws-ec2-task-definition-1.0' do
  title 'Ensure EC2 Task Definition has the correct properties.'

  describe aws_ecs_task_definition(task_definition: 'service:'+aws_ecs_task_definition_revision) do
    it { should exist }
  end

  describe aws_ecs_task_definition(task_definition: 'service:'+aws_ecs_task_definition_revision) do
    its('task_definition_arn') { should eq aws_ecs_task_definition_arn }

    # Container_Definitions
    its('container_definitions_names') { should include 'second' }
    its('container_definitions_images') { should include 'service-second' }
    its('repository_credentials') { should be_empty }
    its('container_definitions_repository_credentials_credentials_parameters') { should_not be_empty }
    its('container_definitions_cpus') { should include 10 }
    its('container_definitions_memories') { should include 512 }
    its('container_definitions_memory_reservations') { should_not be_empty }
    its('container_definitions_links') { should_not be_empty }
    its('container_definitions_port_mappings') { should_not be_empty }
    its('container_definitions_essentials') { should include true }
    its('container_definitions_entry_points') { should_not be_empty }
    its('container_definitions_commands') { should_not be_empty }
    its('container_definitions_environments') { should_not be_empty }
    its('container_definitions_environment_files') { should_not be_empty }
    its('container_definitions_mount_points') { should_not be_empty }
    its('container_definitions_volumes_froms') { should_not be_empty }

    # Container_Definitions - Linux Parameters
    its('container_definitions_linux_parameters') { should_not be_empty }
    its('container_definitions_linux_parameters_capabilities_adds') { should_not be_empty }
    its('container_definitions_linux_parameters_capabilities_drops') { should_not be_empty }
    its('container_definitions_linux_parameters_capabilities_devices') { should_not be_empty }
    its('container_definitions_linux_parameters_capabilities_devices_host_paths') { should_not be_empty }
    its('container_definitions_linux_parameters_capabilities_devices_container_paths') { should_not be_empty }
    its('container_definitions_linux_parameters_capabilities_devices_permissions') { should_not be_empty }
    its('container_definitions_linux_parameters_init_process_enabled') { should_not be_empty }
    its('container_definitions_linux_parameters_shared_memory_sizes') { should_not be_empty }
    its('container_definitions_linux_parameters_tmpfs') { should_not be_empty }
    its('container_definitions_linux_parameters_tmpfs_container_paths') { should_not be_empty }
    its('container_definitions_linux_parameters_tmpfs_sizes') { should_not be_empty }
    its('container_definitions_linux_parameters_tmpfs_mount_options') { should_not be_empty }
    its('container_definitions_linux_parameters_max_swaps') { should_not be_empty }
    its('container_definitions_linux_parameters_swappiness') { should_not be_empty }

    # Container_Definitions - Secrets
    its('container_definitions_secrets') { should_not be_empty }
    its('container_definitions_secrets_names') { should_not be_empty }
    its('container_definitions_secrets_value_froms') { should_not be_empty }

    its('container_definitions_depends_on') { should_not be_empty }
    its('container_definitions_depends_on_container_names') { should_not be_empty }
    its('container_definitions_depends_on_conditions') { should_not be_empty }

    its('container_definitions_start_timeouts') { should_not be_empty }
    its('container_definitions_stop_timeouts') { should_not be_empty }
    its('container_definitions_hostnames') { should_not be_empty }
    its('container_definitions_users') { should_not be_empty }
    its('container_definitions_working_directories') { should_not be_empty }
    its('container_definitions_disable_networkings') { should_not be_empty }
    its('container_definitions_privilegeds') { should_not be_empty }
    its('container_definitions_readonly_root_filesystems') { should_not be_empty }
    its('container_definitions_dns_servers') { should_not be_empty }
    its('container_definitions_dns_search_domains') { should_not be_empty }

    its('container_definitions_extra_hosts') { should_not be_empty }
    its('container_definitions_extra_hosts_hostnames') { should_not be_empty }
    its('container_definitions_extra_hosts_ip_addresses') { should_not be_empty }

    its('container_definitions_docker_security_options') { should_not be_empty }
    its('container_definitions_interactives') { should_not be_empty }
    its('container_definitions_pseudo_terminals') { should_not be_empty }
    its('container_definitions_docker_labels') { should_not be_empty }

    # Container_Definitions - Ulimits
    its('container_definitions_ulimits') { should_not be_empty }
    its('container_definitions_ulimits_names') { should_not be_empty }
    its('container_definitions_ulimits_soft_limits') { should_not be_empty }
    its('container_definitions_ulimits_hard_limits') { should_not be_empty }

    # Container_Definitions - Log Configurations
    its('container_definitions_log_configurations') { should_not be_empty }
    its('container_definitions_log_configurations_log_drivers') { should_not be_empty }
    its('container_definitions_log_configurations_options') { should_not be_empty }

    # Container_Definitions - Log Configurations - Secret - Options
    its('container_definitions_log_configurations_secret_options') { should_not be_empty }
    its('container_definitions_log_configurations_secret_options_names') { should_not be_empty }
    its('container_definitions_log_configurations_secret_value_froms') { should_not be_empty }

    # Container_Definitions - Health Checks
    its('container_definitions_health_checks') { should_not be_empty }
    its('container_definitions_health_checks_commands') { should_not be_empty }
    its('container_definitions_health_checks_intervals') { should_not be_empty }
    its('container_definitions_health_checks_timeouts') { should_not be_empty }
    its('container_definitions_health_checks_retries') { should_not be_empty }
    its('container_definitions_health_checks_start_periods') { should_not be_empty }

    # Container_Definitions - System Controls
    its('container_definitions_system_controls') { should_not be_empty }
    its('container_definitions_system_controls_namespaces') { should_not be_empty }
    its('container_definitions_system_controls_values') { should_not be_empty }

    # Container_Definitions - Resource Requirements
    its('container_definitions_resource_requirements') { should_not be_empty }
    its('container_definitions_resource_requirements_values') { should_not be_empty }
    its('container_definitions_resource_requirements_types') { should_not be_empty }

    # Container_Definitions - Firelens Configurations
    its('container_definitions_firelens_configurations') { should_not be_empty }
    its('container_definitions_firelens_configurations_types') { should_not be_empty }
    its('container_definitions_firelens_configurations_options') { should_not be_empty }

    its('family') { should eq 'service' }
    its('task_role_arn') { should be_empty }
    its('execution_role_arn') { should be_empty }
    its('network_mode') { should be_empty }
    its('revision') { should eq 11 }
    its('volumes') { should_not be_empty }
    its('status') { should eq 'ACTIVE' }

    # Require_Attributes
    its('requires_attributes') { should be_empty }
    its('requires_attributes_name') { should be_empty }
    its('requires_attributes_value') { should be_empty }
    its('requires_attributes_target_type') { should be_empty }
    its('requires_attributes_target') { should be_empty }

    its('placement_constraints') { should_not be_empty }
    its('compatibilities') { should include 'EC2' }

    its('cpu') { should be_empty }
    its('memory') { should be_empty }

    # Interference Accelerators
    its('inference_accelerators') { should be_empty }
    its('inference_accelerators_device_name') { should be_empty }
    its('inference_accelerators_device_type') { should be_empty }

    its('pid_mode') { should be_empty }
    its('ipc_mode') { should be_empty }

    # Proxy_Configuration
    its('proxy_configuration') { should be_empty }
    its('proxy_configuration_type') { should be_empty }
    its('proxy_configuration_container_name') { should be_empty }
    its('proxy_configuration_properties') { should be_empty }
    its('proxy_configuration_properties_name') { should be_empty }
    its('proxy_configuration_properties_value') { should be_empty }
    its('tags') { should be_empty }
  end

  describe aws_ecs_task_definition(task_definition: 'dummy') do
    it { should_not exist }
  end
end
