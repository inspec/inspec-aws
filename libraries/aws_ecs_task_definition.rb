require "aws_backend"

class AWSECSTaskDefinition < AwsResourceBase
  name "aws_ecs_task_definition"
  desc "Describes a task definition."

  example "
    describe aws_ecs_task_definition(task_definition: 'hello_world:8') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { task_definition: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:task_definition])
    raise ArgumentError, "#{@__resource_name__}: task_definition must be provided" unless opts[:task_definition] && !opts[:task_definition].empty?
    @display_name = opts[:task_definition]
    catch_aws_errors do
      resp = @aws.ecs_client.describe_task_definition({ task_definition: opts[:task_definition] })
      @task_definition = resp.task_definition.to_h
      create_resource_methods(@task_definition)
    end
  end

  def task_definition
    return nil unless exists?
    @task_definition[:task_definition]
  end

  def exists?
    !@task_definition.nil? && !@task_definition.empty?
  end

  def container_definitions_names
    container_definitions.map(&:name)
  end

  def container_definitions_images
    container_definitions.map(&:image)
  end

  def container_definitions_repository_credentials
    container_definitions.map(&:repository_credentials)
  end

  def container_definitions_repository_credentials_credentials_parameters
    container_definitions.map(&:repository_credentials).map(&:credentials_parameter)
  end

  def container_definitions_cpus
    container_definitions.map(&:cpu)
  end

  def container_definitions_memories
    container_definitions.map(&:memory)
  end

  def container_definitions_memory_reservations
    container_definitions.map(&:memory_reservation)
  end

  def container_definitions_links
    container_definitions.map(&:links)
  end

  def container_definitions_port_mappings
    container_definitions.map(&:port_mappings)
  end

  def container_definitions_port_mappings_container_ports
    container_definitions.map(&:port_mappings).map(&:container_port)
  end

  def container_definitions_port_mappings_host_ports
    container_definitions.map(&:port_mappings).map(&:host_port)
  end

  def container_definitions_port_mappings_protocols
    container_definitions.map(&:port_mappings).map(&:protocol)
  end

  def container_definitions_essentials
    container_definitions.map(&:essential)
  end

  def container_definitions_entry_points
    container_definitions.map(&:entry_point)
  end

  def container_definitions_commands
    container_definitions.map(&:command)
  end

  def container_definitions_environments
    container_definitions.map(&:environment)
  end

  def container_definitions_environments_names
    container_definitions.map(&:environment).map(&:name)
  end

  def container_definitions_environments_values
    container_definitions.map(&:environment).map(&:value)
  end

  def container_definitions_environment_files
    container_definitions.map(&:environment_files)
  end

  def container_definitions_environment_files_values
    container_definitions.map(&:environment_files).map(&:value)
  end

  def container_definitions_environment_files_types
    container_definitions.map(&:environment_files).map(&:type)
  end

  def container_definitions_mount_points
    container_definitions.map(&:mount_points)
  end

  def container_definitions_mount_points_source_volumes
    container_definitions.map(&:mount_points).map(&:source_volume)
  end

  def container_definitions_mount_points_container_paths
    container_definitions.map(&:mount_points).map(&:container_path)
  end

  def container_definitions_mount_points_read_only
    container_definitions.map(&:mount_points).map(&:read_only)
  end

  def container_definitions_volumes_froms
    container_definitions.map(&:volumes_from)
  end

  def container_definitions_volumes_froms_source_containers
    container_definitions.map(&:volumes_from).map(&:source_container)
  end

  def container_definitions_volumes_froms_read_only
    container_definitions.map(&:volumes_from).map(&:read_only)
  end

  def container_definitions_linux_parameters
    container_definitions.map(&:linux_parameters)
  end

  def container_definitions_linux_parameters_capabilities_adds
    container_definitions.map(&:linux_parameters).map(&:add)
  end

  def container_definitions_linux_parameters_capabilities_drops
    container_definitions.map(&:linux_parameters).map(&:drop)
  end

  def container_definitions_linux_parameters_capabilities_devices
    container_definitions.map(&:linux_parameters).map(&:devices)
  end

  def container_definitions_linux_parameters_capabilities_devices_host_paths
    container_definitions.map(&:linux_parameters).map(&:devices).map(&:host_path)
  end

  def container_definitions_linux_parameters_capabilities_devices_container_paths
    container_definitions.map(&:linux_parameters).map(&:devices).map(&:container_path)
  end

  def container_definitions_linux_parameters_capabilities_devices_permissions
    container_definitions.map(&:linux_parameters).map(&:devices).map(&:permissions)
  end

  def container_definitions_linux_parameters_init_process_enabled
    container_definitions.map(&:linux_parameters).map(&:init_process_enabled)
  end

  def container_definitions_linux_parameters_shared_memory_sizes
    container_definitions.map(&:linux_parameters).map(&:shared_memory_size)
  end

  def container_definitions_linux_parameters_tmpfs
    container_definitions.map(&:linux_parameters).map(&:tmpfs)
  end

  def container_definitions_linux_parameters_tmpfs_container_paths
    container_definitions.map(&:linux_parameters).map(&:tmpfs).map(&:container_path)
  end

  def container_definitions_linux_parameters_tmpfs_sizes
    container_definitions.map(&:linux_parameters).map(&:tmpfs).map(&:size)
  end

  def container_definitions_linux_parameters_tmpfs_mount_options
    container_definitions.map(&:linux_parameters).map(&:tmpfs).map(&:mount_options)
  end

  def container_definitions_linux_parameters_max_swaps
    container_definitions.map(&:linux_parameters).map(&:max_swap)
  end

  def container_definitions_linux_parameters_swappiness
    container_definitions.map(&:linux_parameters).map(&:swappiness)
  end

  def container_definitions_secrets
    container_definitions.map(&:secrets)
  end

  def container_definitions_secrets_names
    container_definitions.map(&:secrets).map(&:name)
  end

  def container_definitions_secrets_value_froms
    container_definitions.map(&:secrets).map(&:value_from)
  end

  def container_definitions_depends_on
    container_definitions.map(&:depends_on)
  end

  def container_definitions_depends_on_container_names
    container_definitions.map(&:depends_on).map(&:container_name)
  end

  def container_definitions_depends_on_conditions
    container_definitions.map(&:depends_on).map(&:condition)
  end

  def container_definitions_start_timeouts
    container_definitions.map(&:start_timeout)
  end

  def container_definitions_stop_timeouts
    container_definitions.map(&:stop_timeout)
  end

  def container_definitions_hostnames
    container_definitions.map(&:hostname)
  end

  def container_definitions_users
    container_definitions.map(&:users)
  end

  def container_definitions_working_directories
    container_definitions.map(&:working_directory)
  end

  def container_definitions_disable_networkings
    container_definitions.map(&:disable_networking)
  end

  def container_definitions_privilegeds
    container_definitions.map(&:privileged)
  end

  def container_definitions_readonly_root_filesystems
    container_definitions.map(&:readonly_root_filesystem)
  end

  def container_definitions_dns_servers
    container_definitions.map(&:dns_servers)
  end

  def container_definitions_dns_search_domains
    container_definitions.map(&:dns_search_domains)
  end

  def container_definitions_extra_hosts
    container_definitions.map(&:extra_hosts)
  end

  def container_definitions_extra_hosts_hostnames
    container_definitions.map(&:extra_hosts).map(&:hostname)
  end

  def container_definitions_extra_hosts_ip_addresses
    container_definitions.map(&:extra_hosts).map(&:ip_address)
  end

  def container_definitions_docker_security_options
    container_definitions.map(&:docker_security_options)
  end

  def container_definitions_interactives
    container_definitions.map(&:interactive)
  end

  def container_definitions_pseudo_terminals
    container_definitions.map(&:pseudo_terminal)
  end

  def container_definitions_docker_labels
    container_definitions.map(&:docker_labels)
  end

  def container_definitions_ulimits
    container_definitions.map(&:ulimits)
  end

  def container_definitions_ulimits_names
    container_definitions.map(&:ulimits).map(&:name)
  end

  def container_definitions_ulimits_soft_limits
    container_definitions.map(&:ulimits).map(&:soft_limit)
  end

  def container_definitions_ulimits_hard_limits
    container_definitions.map(&:ulimits).map(&:hard_limit)
  end

  def container_definitions_log_configurations
    container_definitions.map(&:log_configuration)
  end

  def container_definitions_log_configurations_log_drivers
    container_definitions.map(&:log_configuration).map(&:log_driver)
  end

  def container_definitions_log_configurations_options
    container_definitions.map(&:log_configuration).map(&:options)
  end

  def container_definitions_log_configurations_secret_options
    container_definitions.map(&:log_configuration).map(&:secret_options)
  end

  def container_definitions_log_configurations_secret_options_names
    container_definitions.map(&:log_configuration).map(&:secret_options).map(&:name)
  end

  def container_definitions_log_configurations_secret_value_froms
    container_definitions.map(&:log_configuration).map(&:secret_options).map(&:value_from)
  end

  def container_definitions_health_checks
    container_definitions.map(&:health_check)
  end

  def container_definitions_health_checks_commands
    container_definitions.map(&:health_check).map(&:command)
  end

  def container_definitions_health_checks_intervals
    container_definitions.map(&:health_check).map(&:interval)
  end

  def container_definitions_health_checks_timeouts
    container_definitions.map(&:health_check).map(&:timeout)
  end

  def container_definitions_health_checks_retries
    container_definitions.map(&:health_check).map(&:retries)
  end

  def container_definitions_health_checks_start_periods
    container_definitions.map(&:health_check).map(&:start_period)
  end

  def container_definitions_system_controls
    container_definitions.map(&:system_controls)
  end

  def container_definitions_system_controls_namespaces
    container_definitions.map(&:system_controls).map(&:namespace)
  end

  def container_definitions_system_controls_values
    container_definitions.map(&:system_controls).map(&:value)
  end

  def container_definitions_resource_requirements
    container_definitions.map(&:resource_requirements)
  end

  def container_definitions_resource_requirements_values
    container_definitions.map(&:resource_requirements).map(&:value)
  end

  def container_definitions_resource_requirements_types
    container_definitions.map(&:resource_requirements).map(&:type)
  end

  def container_definitions_firelens_configurations
    container_definitions.map(&:firelens_configuration)
  end

  def container_definitions_firelens_configurations_types
    container_definitions.map(&:firelens_configuration).map(&:type)
  end

  def container_definitions_firelens_configurations_options
    container_definitions.map(&:firelens_configuration).map(&:options)
  end

  def volumes_names
    volumes.map(&:name)
  end

  def volumes_hosts
    volumes.map(&:host)
  end

  def volumes_source_paths
    volumes.map(&:source_path)
  end

  def volumes_docker_volume_configurations
    volumes.map(&:docker_volume_configuration)
  end

  def volumes_docker_volume_configuration_scopes
    volumes.map(&:docker_volume_configuration).map(&:scope)
  end

  def volumes_docker_volume_configuration_autoprovisions
    volumes.map(&:docker_volume_configuration).map(&:autoprovision)
  end

  def volumes_docker_volume_configuration_drivers
    volumes.map(&:docker_volume_configuration).map(&:driver)
  end

  def volumes_docker_volume_configuration_driver_opts
    volumes.map(&:docker_volume_configuration).map(&:driver_opts)
  end

  def volumes_docker_volume_configuration_labels
    volumes.map(&:docker_volume_configuration).map(&:labels)
  end

  def volumes_efs_volume_configurations
    volumes.map(&:efs_volume_configurations)
  end

  def volumes_efs_volume_configuration_file_system_ids
    volumes.map(&:efs_volume_configurations).map(&:file_system_id)
  end

  def volumes_efs_volume_configuration_root_directories
    volumes.map(&:efs_volume_configurations).map(&:root_directory)
  end

  def volumes_efs_volume_configuration_transit_encryptions
    volumes.map(&:efs_volume_configurations).map(&:transit_encryption)
  end

  def volumes_efs_volume_configuration_transit_encryption_ports
    volumes.map(&:efs_volume_configurations).map(&:transit_encryption_port)
  end

  def volumes_efs_volume_configuration_authorization_configs
    volumes.map(&:efs_volume_configurations).map(&:authorization_config)
  end

  def volumes_efs_volume_configuration_authorization_config_access_point_ids
    volumes.map(&:efs_volume_configurations).map(&:authorization_config).map(&:access_point_id)
  end

  def volumes_efs_volume_configuration_authorization_config_iams
    volumes.map(&:efs_volume_configurations).map(&:authorization_config).map(&:iam)
  end

  def volumes_fsx_windows_file_server_volume_configurations
    volumes.map(&:fsx_windows_file_server_volume_configuration)
  end

  def volumes_fsx_windows_file_server_volume_configurations_file_system_ids
    volumes.map(&:fsx_windows_file_server_volume_configuration).map(&:file_system_id)
  end

  def volumes_fsx_windows_file_server_volume_configurations_root_directories
    volumes.map(&:fsx_windows_file_server_volume_configuration).map(&:root_directory)
  end

  def volumes_fsx_windows_file_server_volume_configurations_authorization_configs
    volumes.map(&:fsx_windows_file_server_volume_configuration).map(&:authorization_config)
  end

  def volumes_fsx_windows_file_server_volume_configurations_authorization_configs_credentials_parameters
    volumes.map(&:fsx_windows_file_server_volume_configuration).map(&:authorization_config).map(&:credentials_parameter)
  end

  def volumes_fsx_windows_file_server_volume_configurations_authorization_configs_domains
    volumes.map(&:fsx_windows_file_server_volume_configuration).map(&:authorization_config).map(&:domain)
  end

  def requires_attributes_names
    requires_attributes.map(&:name)
  end

  def requires_attributes_values
    requires_attributes.map(&:value)
  end

  def requires_attributes_target_types
    requires_attributes.map(&:target_type)
  end

  def requires_attributes_targets
    requires_attributes.map(&:target)
  end

  def placement_constraints_types
    placement_constraints.map(&:type)
  end

  def placement_constraints_expressions
    placement_constraints.map(&:expression)
  end

  def inference_accelerators_device_names
    inference_accelerators.map(&:device_name)
  end

  def inference_accelerators_device_types
    inference_accelerators.map(&:device_type)
  end

  def proxy_configuration_types
    proxy_configuration.map(&:type)
  end

  def proxy_configuration_container_names
    proxy_configuration.map(&:container_name)
  end

  def proxy_configuration_properties
    proxy_configuration.map(&:properties)
  end

  def proxy_configuration_properties_names
    proxy_configuration.map(&:properties).map(&:name)
  end

  def proxy_configuration_properties_values
    proxy_configuration.map(&:properties).map(&:value)
  end

  def resource_id
    return @display_name unless exists?
    @task_definition[:task_definition_arn]
  end

  def to_s
    "Task Definition Name: #{@display_name}"
  end
end
