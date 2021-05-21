aws_job_definition_name = attribute("aws_job_definition_name", default: "test1", description: "")
aws_job_definition_arn = attribute("aws_job_definition_arn", default: "arn:aws:batch:us-east-2:112758395563:job-definition/test1:1", description: "")
aws_revision = attribute("aws_revision", default: 1, description: "")
aws_status = attribute("aws_status", default: "ACTIVE", description: "")
aws_type = attribute("aws_type", default: "container", description: "")
aws_parameters = attribute("aws_parameters", default: "", description: "")
aws_container_properties = attribute("aws_job_definition_name", default: "test1", description: "")
aws_container_properties_image = attribute("aws_container_properties_image", default: "amazonlinux", description: "")
aws_container_properties_vcpus = attribute("aws_container_properties_vcpus", default: "", description: "")
aws_container_properties_memory = attribute("aws_container_properties_memory", default: "", description: "")
aws_container_properties_command = attribute("aws_container_properties_command", default: "echo", description: "")
aws_container_properties_job_role_arn = attribute("aws_container_properties_job_role_arn", default: "", description: "")
aws_container_properties_execution_role_arn = attribute("aws_container_propertie_execution_role_arn", default: "arn:aws:iam::112758395563:role/ecs-logs", description: "")
aws_container_properties_volumes = attribute("aws_container_properties_volumes", default: "", description: "")
aws_container_properties_environment = attribute("aws_container_properties_environment", default: "", description: "")
aws_container_properties_mount_points = attribute("aws_container_properties_mount_points", default: "", description: "")
aws_container_properties_readonly_root_filesystem = attribute("aws_container_properties_readonly_root_filesystem", default: "", description: "")
aws_container_properties_privileged = attribute("aws_container_properties_readonly_root_filesystem", default: "", description: "")
aws_container_properties_ulimits = attribute("aws_container_properties_ulimits", default: "", description: "")
aws_container_properties_user = attribute("aws_container_properties_user", default: "", description: "")
aws_container_properties_instance_type = attribute("aws_container_properties_instance_type", default: "", description: "")
aws_container_properties_resource_requirements = attribute("aws_container_properties_resource_requirements", default: "", description: "")
aws_container_properties_linux_parameters_devices = attribute("aws_container_properties_linux_parameters_devices", default: "", description: "")
aws_container_properties_linux_parameters_init_process_enabled = attribute("aws_container_properties_linux_parameters_init_process_enabled", default: "", description: "")
aws_container_properties_linux_parameters_shared_memory_size = attribute("aws_container_properties_linux_parameters_shared_memory_size", default: "", description: "")
aws_container_properties_linux_parameters_tmpfs = attribute("aws_container_properties_linux_parameters_tmpfs", default: "", description: "")
aws_container_properties_linux_parameters_max_swap = attribute("aws_container_properties_linux_parameters_max_swap", default: "", description: "")
aws_container_properties_linux_parameters_swappiness = attribute("aws_container_properties_linux_parameters_swappiness", default: "", description: "")
aws_container_properties_log_configuration_log_driver = attribute("aws_container_properties_log_configuration_log_driver", default: "", description: "")
aws_container_properties_log_configuration_options = attribute("aws_container_properties_log_configuration_options", default: "", description: "")
aws_container_properties_secrets = attribute("aws_container_properties_secrets", default: "", description: "")
aws_timeout_attempt_duration_seconds = attribute("aws_timeout_attempt_duration_seconds", default: "", description: "")
aws_node_properties_num_nodes = attribute("aws_node_properties_num_nodes", default: "", description: "")
aws_node_properties_main_node = attribute("aws_node_properties_main_node", default: "", description: "")
aws_node_properties_node_range_properties = attribute("aws_node_properties_node_range_properties", default: "", description: "")
aws_tags = attribute("aws_tags", default: "", description: "")
aws_propagate_tags = attribute("aws_propagate_tags", default: false, description: "")
aws_platform_capabilities = attribute("aws_job_definition_name", default: "FARGATE", description: "")


describe aws_batch_job_definition(job_definition_name: aws_job_definition_name) do
  it { should exist }
  its('job_definition_name') { should eq aws_job_definition_name }
  its('job_definition_arn') { should eq aws_job_definition_arn }
  its('revision') { should eq aws_revision }
  its('status') { should eq aws_status }
  its('type') { should eq aws_type }
  its('parameters') { should be_empty }

  its('container_properties.image') { should eq aws_container_properties_image }
  its('container_properties.vcpus') { should be_empty }
  its('container_properties.memory') { should be_empty }
  its('container_properties.command') { should include aws_container_properties_command }
  its('container_properties.job_role_arn') { should be_empty }
  its('container_properties.execution_role_arn') { should eq aws_container_properties_execution_role_arn }
  its('container_properties.volumes') { should be_empty }
  its('container_properties.environment') { should be_empty }
  its('container_properties.mount_points') { should be_empty }
  its('container_properties.readonly_root_filesystem') { should be_empty }
  its('container_properties.privileged') { should be_empty }
  its('container_properties.ulimits') { should be_empty }
  its('container_properties.user') { should be_empty }
  its('container_properties.instance_type') { should be_empty }
  its('container_properties.resource_requirements') { should_not be_empty }
  its('container_properties.linux_parameters.shared_memory_size') { should be_empty }
  its('container_properties.linux_parameters.tmpfs') { should be_empty }
  its('container_properties.linux_parameters.max_swap') { should be_empty }
  its('container_properties.linux_parameters.swappiness') { should be_empty }
  its('container_properties.log_configuration.log_driver') { should be_empty }
  its('container_properties.log_configuration.options') { should be_empty }
  its('container_properties.secrets') { should be_empty }

  # its('timeout.attempt_duration_seconds') { should eq 0 }
  
  its('node_properties.num_nodes') { should be_empty }
  its('node_properties.main_node') { should be_empty }
  its('node_properties.node_range_properties') { should be_empty }

  its('tags') { should be_empty }
  its('propagate_tags') { should eq aws_propagate_tags }
  its('platform_capabilities') { should include aws_platform_capabilities }
end