+++
title = "aws_ecs_task_definition resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ecs_task_definition"
identifier = "inspec/resources/aws/aws_ecs_task_definition resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ecs_task_definition` InSpec audit resource to test the properties of a single ECS task definition.

For additional information, including details on parameters and properties, see the [AWS ECS task definition documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-taskdefinition.html).

## Syntax

Ensure that a task definition exists.

```ruby
describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
  it { should exist }
end
```

## Parameters

`task_definition` _(required)_

: The full task definition description.
  Specified as just the `family`, which targets the latest active revision, or `family:revision` for a specific revision number of a family, or the full Amazon Resource Name (ARN) of the task definition.

## Properties

`task_definition_arn`
: The full Amazon Resource Name (ARN) of the task definition.

: **Field**: `task_definition_arn`

`container_definitions`
: A list of container definitions in JSON format that describe the different containers that make up your task.

: **Field**: `container_definitions`

`container_definitions (name)`
: The name of a container.

: **Field**: `container_definitions_names`

`container_definitions (image)`
: The image used to start a container.

: **Field**: `container_definitions_images`

`container_definitions (repository_credentials)`
: The private repository authentication credentials to use.

: **Field**: `container_definitions_repository_credentials`

`container_definitions (repository_credentials (credentials_parameter))`
: The Amazon Resource Name (ARN) of the secret containing the private repository credentials.

: **Field**: `container_definitions_repository_credentials_credentials_parameters`

`container_definitions (cpu)`
: The number of CPU units reserved for the container.

: **Field**: `container_definitions_cpus`

`container_definitions (memory)`
: The amount (in MiB) of memory to present to the container.

: **Field**: `container_definitions_memories`

`container_definitions (memory_reservation)`
: The soft limit (in MiB) of memory to reserve for the container.

: **Field**: `container_definitions_memory_reservations`

`container_definitions (links)`
: The links parameter allows containers to communicate with each other without the need for port mappings.

: **Field**: `container_definitions_links`

`container_definitions (port_mappings)`
: The list of port mappings for the container.

: **Field**: `container_definitions_port_mappings`

`container_definitions (port_mappings (container_port))`
: The port number on the container that is bound to the user-specified or automatically assigned host port.

: **Field**: `container_definitions_port_mappings_container_ports`

`container_definitions (port_mappings (host_port))`
: The port number on the container instance to reserve for your container.

: **Field**: `container_definitions_port_mappings_host_ports`

`container_definitions (port_mappings (protocol))`
: The protocol used for the port mapping. Valid values are `tcp` and `udp`. Default value: `tcp`.

: **Field**: `container_definitions_port_mappings_protocols`

`container_definitions (essential)`
: If the essential parameter of a container is marked as `true`, and that container fails or stops for any reason, all other containers that are part of the task are stopped. If the essential parameter of a container is marked as `false`, then its failure does not affect the rest of the containers in a task. If this parameter is omitted, a container is assumed to be essential.

: **Field**: `container_definitions_essentials`

`container_definitions (entry_point)`
: The entry point that is passed to the container.

: **Field**: `container_definitions_entry_points`

`container_definitions (command)`
: The command that is passed to the container.

: **Field**: `container_definitions_commands`

`container_definitions (environment)`
: The environment variables to pass to a container.

: **Field**: `container_definitions_environments`

`container_definitions (environment (name))`
: The name of the key-value pair.

: **Field**: `container_definitions_environments_names`

`container_definitions (environment (value))`
: The value of the key-value pair.

: **Field**: `container_definitions_environments_values`

`container_definitions (environment_files)`
: A list of files containing the environment variables to pass to a container.

: **Field**: `container_definitions_environment_files`

`container_definitions (environment_files (value)`
: The Amazon Resource Name (ARN) of the Amazon S3 object containing the environment variable file.

: **Field**: `container_definitions_environment_files_values`

`container_definitions (environment_files (type)`
: The file type to use. The only supported value is `s3`.

: **Field**: `container_definitions_environment_files_types`

`container_definitions (mount_points)`
: The mount points for data volumes in your container.

: **Field**: `container_definitions_mount_points`

`container_definitions (mount_points (source_volume))`
: The name of the volume to mount. Must be a volume name referenced in the name parameter of task definition volume.

: **Field**: `container_definitions_mount_points_source_volumes`

`container_definitions (mount_points (container_path))`
: The path on the container to mount the host volume at.

: **Field**: `container_definitions_mount_points_container_paths`

`container_definitions (mount_points (read_only))`
: If this value is `true`, the container has read-only access to the volume. If this value is `false`, then the container can write to the volume. The default value is `false`.

: **Field**: `container_definitions_mount_points_read_only`

`container_definitions (volumes_from)`
: Data volumes to mount from another container.

: **Field**: `container_definitions_volumes_froms`

`container_definitions (volumes_from (source_container))`
: The name of another container within the same task definition from which to mount volumes.

: **Field**: `container_definitions_volumes_froms_source_containers`

`container_definitions (volumes_from (read_only))`
: If this value is `true`, the container has read-only access to the volume. If this value is `false`, then the container can write to the volume. The default value is `false`.

: **Field**: `container_definitions_volumes_froms_read_only`

`container_definitions (linux_parameters)`
: Linux-specific modifications that are applied to the container, such as Linux kernel capabilities.

: **Field**: `container_definitions_linux_parameters`

`container_definitions (linux_parameters (capabilities))`
: The Linux capabilities for the container that are added to or dropped from the default configuration provided by Docker.

: **Field**: `container_definitions_linux_parameters_capabilities`

`container_definitions (linux_parameters (capabilities (add)))`
: The Linux capabilities for the container that have been added to the default configuration provided by Docker.

: **Field**: `container_definitions_linux_parameters_capabilities_adds`

`container_definitions (linux_parameters (capabilities (drop)))`
: The Linux capabilities for the container that have been removed from the default configuration provided by Docker.

: **Field**: `container_definitions_linux_parameters_capabilities_drops`

`container_definitions (linux_parameters (devices))`
: Any host devices to expose to the container.

: **Field**: `container_definitions_linux_parameters_capabilities_devices`

`container_definitions (linux_parameters (devices (host_path)))`
: The path for the device on the host container instance.

: **Field**: `container_definitions_linux_parameters_capabilities_devices_host_paths`

`container_definitions (linux_parameters (devices (container_path)))`
: The path inside the container at which to expose the host device.

: **Field**: `container_definitions_linux_parameters_capabilities_devices_container_paths`

`container_definitions (linux_parameters (devices (permissions)))`
: The explicit permissions to provide to the container for the device. By default, the container has permissions for `read`, `write`, and `mknod` for the device.

: **Field**: `container_definitions_linux_parameters_capabilities_devices_permissions`

`container_definitions (linux_parameters (init_process_enabled))`
: Run an `init` process inside the container that forwards signals and reaps processes. This parameter maps to the `--init` option to docker run.

: **Field**: `container_definitions_linux_parameters_init_process_enabled`

`container_definitions (linux_parameters (shared_memory_size)`
: The value for the size (in MiB) of the /dev/shm volume. This parameter maps to the `--shm-size` option to docker run.

: **Field**: `container_definitions_linux_parameters_shared_memory_sizes`

`container_definitions (linux_parameters (tmpfs)`
: The container path, mount options, and size (in MiB) of the tmpfs mount. This parameter maps to the `--tmpfs` option to docker run.

: **Field**: `container_definitions_linux_parameters_tmpfs`

`container_definitions (linux_parameters (tmpfs (container_path))`
: The absolute file path where the tmpfs volume is to be mounted.

: **Field**: `container_definitions_linux_parameters_tmpfs_container_paths`

`container_definitions (linux_parameters (tmpfs (size))`
: The maximum size (in MiB) of the tmpfs volume.

: **Field**: `container_definitions_linux_parameters_tmpfs_sizes`

`container_definitions (linux_parameters (tmpfs (mount_options))`
: The list of tmpfs volume mount options.

: **Field**: `container_definitions_linux_parameters_tmpfs_mount_options`

`container_definitions (linux_parameters (max_swap))`
: The total amount of swap memory (in MiB) a container can use.

: **Field**: `container_definitions_linux_parameters_max_swaps`

`container_definitions (linux_parameters (swappiness))`
: This allows you to tune a container's memory swappiness behavior.

: **Field**: `container_definitions_linux_parameters_swappiness`

`container_definitions (secrets)`
: The secrets to pass to the container.

: **Field**: `container_definitions_secrets`

`container_definitions (secrets (name))`
: The name of the secret.

: **Field**: `container_definitions_secrets_names`

`container_definitions (secrets (value_from))`
: The secret to expose to the container.

: **Field**: `container_definitions_secrets_value_froms`

`container_definitions (depends_on)`
: The dependencies defined for container startup and shutdown.

: **Field**: `container_definitions_depends_on`

`container_definitions (depends_on (container_name))`
: The name of a container.

: **Field**: `container_definitions_depends_on_container_names`

`container_definitions (depends_on (condition))`
: The dependency condition of the container.

: **Field**: `container_definitions_depends_on_conditions`

`container_definitions (start_timeout)`
: Time duration (in seconds) to wait before giving up on resolving dependencies for a container.

: **Field**: `container_definitions_start_timeouts`

`container_definitions (stop_timeout)`
: Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own.

: **Field**: `container_definitions_stop_timeouts`

`container_definitions (hostname)`
: The hostname to use for your container.

: **Field**: `container_definitions_hostnames`

`container_definitions (user)`
: The user to use inside the container.

: **Field**: `container_definitions_users`

`container_definitions (working_directory)`
: The working directory in which to run commands inside the container.

: **Field**: `container_definitions_working_directories`

`container_definitions (disable_networking)`
: When this parameter is `true`, networking is disabled within the container.

: **Field**: `container_definitions_disable_networkings`

`container_definitions (privileged)`
: When this parameter is `true`, the container is given elevated privileges on the host container instance (similar to the root user).

: **Field**: `container_definitions_privilegeds`

`container_definitions (readonly_root_filesystem)`
: When this parameter is `true`, the container is given read-only access to its root file system. This parameter maps to `ReadonlyRootfs` in the Create a container section of the Docker Remote API and the `--read-only` option to docker run.

: **Field**: `container_definitions_readonly_root_filesystems`

`container_definitions (dns_servers)`
: A list of DNS servers that are presented to the container.

: **Field**: `container_definitions_dns_servers`

`container_definitions (dns_search_domains)`
: A list of DNS search domains that are presented to the container.

: **Field**: `container_definitions_dns_search_domains`

`container_definitions (extra_hosts)`
: A list of hostnames and IP address mappings to append to the `/etc/hosts` file on the container.

: **Field**: `container_definitions_extra_hosts`

`container_definitions (extra_hosts (hostname))`
: The hostname to use in the `/etc/hosts` entry.

: **Field**: `container_definitions_extra_hosts_hostnames`

`container_definitions (extra_hosts (ip_address))`
: The IP address to use in the `/etc/hosts` entry.

: **Field**: `container_definitions_extra_hosts_ip_addresses`

`container_definitions (docker_security_options)`
: A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems. This field is not valid for containers in tasks using the Fargate launch type.

: **Field**: `container_definitions_docker_security_options`

`container_definitions (interactive)`
: When this parameter is `true`, this allows you to deploy containerized applications that require stdin or a tty to be allocated. This parameter maps to OpenStdin in the Create a container section of the Docker Remote API and the --interactive option to docker run.

: **Field**: `container_definitions_interactives`

`container_definitions (pseudo_terminal)`
: When this parameter is `true`, a TTY is allocated. This parameter maps to Tty in the Create a container section of the Docker Remote API and the --tty option to docker run.

: **Field**: `container_definitions_pseudo_terminals`

`container_definitions (docker_labels)`
: A key/value map of labels to add to the container.

: **Field**: `container_definitions_docker_labels`

`container_definitions (ulimits)`
: The ulimit settings to pass to the container.

: **Field**: `container_definitions_ulimits`

`container_definitions (ulimits (name))`
: The type of the ulimit.

: **Field**: `container_definitions_ulimits_names`

`container_definitions (ulimits (soft_limit))`
: The soft limit for the ulimit type.

: **Field**: `container_definitions_ulimits_soft_limits`

`container_definitions (ulimits (hard_limit))`
: The hard limit for the ulimit type.

: **Field**: `container_definitions_ulimits_hard_limits`

`container_definitions (log_configuration)`
: The log configuration specification for the container.

: **Field**: `container_definitions_log_configurations`

`container_definitions (log_configuration (log_driver))`
: The log driver to use for the container.

: **Field**: `container_definitions_log_configurations_log_drivers`

`container_definitions (log_configuration (options))`
: The configuration options to send to the log driver.

: **Field**: `container_definitions_log_configurations_options`

`container_definitions (log_configuration (secret_options))`
: The secrets to pass to the log configuration.

: **Field**: `container_definitions_log_configurations_secret_options`

`container_definitions (log_configuration (secret_options (name)))`
: The name of the secret.

: **Field**: `container_definitions_log_configurations_secret_options_names`

`container_definitions (log_configuration (secret_options (value_from)))`
: The secret to expose to the container. The supported values are either the full ARN of the AWS Secrets Manager secret or the full ARN of the parameter in the AWS Systems Manager Parameter Store.

: **Field**: `container_definitions_log_configurations_secret_value_froms`

`container_definitions (health_check)`
: The container health check command and associated configuration parameters for the container.

: **Field**: `container_definitions_health_checks`

`container_definitions (health_check (command))`
: A string array representing the command that the container runs to determine if it is healthy.

: **Field**: `container_definitions_health_checks_commands`

`container_definitions (health_check (interval))`
: The time period in seconds between each health check execution.

: **Field**: `container_definitions_health_checks_intervals`

`container_definitions (health_check (timeout))`
: The time period in seconds to wait for a health check to succeed before it is considered a failure.

: **Field**: `container_definitions_health_checks_timeouts`

`container_definitions (health_check (retries))`
: The number of times to retry a failed health check before the container is considered unhealthy.

: **Field**: `container_definitions_health_checks_retries`

`container_definitions (health_check (start_period))`
: The optional grace period within which to provide containers time to bootstrap before failed health checks count towards the maximum number of retries.

: **Field**: `container_definitions_health_checks_start_periods`

`container_definitions (system_controls)`
: A list of namespaced kernel parameters to set in the container.

: **Field**: `container_definitions_system_controls`

`container_definitions (system_controls (namespace))`
: The namespaced kernel parameter for which to set a value.

: **Field**: `container_definitions_system_controls_namespaces`

`container_definitions (system_controls (value))`
: The value for the namespaced kernel parameter specified in namespace.

: **Field**: `container_definitions_system_controls_values`

`container_definitions (resource_requirements)`
: The type and amount of a resource to assign to a container.

: **Field**: `container_definitions_resource_requirements`

`container_definitions (resource_requirements (value))`
: The value for the specified resource type.

: **Field**: `container_definitions_resource_requirements_values`

`container_definitions (resource_requirements (type))`
: The type of resource to assign to a container.

: **Field**: `container_definitions_resource_requirements_types`

`container_definitions (firelens_configuration)`
: The FireLens configuration for the container.

: **Field**: `container_definitions_firelens_configurations`

`container_definitions (firelens_configuration (type))`
: The log router to use. The valid values are `fluentd` or `fluentbit`.

: **Field**: `container_definitions_firelens_configurations_types`

`container_definitions (firelens_configuration (options))`
: The options to use when configuring the log router.

: **Field**: `container_definitions_firelens_configurations_options`

`family`
: The name of a family that this task definition is registered to.

: **Field**: `family`

`task_role_arn`
: The short name or full Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role.

: **Field**: `task_role_arn`

`execution_role_arn`
: The Amazon Resource Name (ARN) of the task execution role that grants the Amazon ECS container.

: **Field**: `execution_role_arn`

`network_mode`
: The Docker networking mode to use for the containers in the task. The valid values are `none`, `bridge`, `awsvpc`, and `host`.

: **Field**: `network_mode`

`revision`
: The revision of the task in a particular family.

: **Field**: `revision`

`volumes`
: The list of data volume definitions for the task.

: **Field**: `volumes`

`volumes (name)`
: The name of the volume.

: **Field**: `volumes_names`

`volumes (host)`
: The host of the volume.

: **Field**: `volumes_hosts`

`volumes (host (source_path))`
: The source path of the volume.

: **Field**: `volumes_source_paths`

`volumes (docker_volume_configuration)`
: This parameter is specified when you are using Docker volumes.

: **Field**: `volumes_docker_volume_configurations`

`volumes (docker_volume_configuration (scope))`
: The scope for the Docker volume that determines its lifecycle.

: **Field**: `volumes_docker_volume_configuration_scopes`

`volumes (docker_volume_configuration (autoprovision))`
: If this value is `true`, the Docker volume is created if it does not already exist.

: **Field**: `volumes_docker_volume_configuration_autoprovisions`

`volumes (docker_volume_configuration (driver))`
: The Docker volume driver to use.

: **Field**: `volumes_docker_volume_configuration_drivers`

`volumes (docker_volume_configuration (driver_opts))`
: A map of Docker driver-specific options passed through.

: **Field**: `volumes_docker_volume_configuration_driver_opts`

`volumes (docker_volume_configuration (labels))`
: Custom metadata to add to your Docker volume.

: **Field**: `volumes_docker_volume_configuration_labels`

`volumes (efs_volume_configuration)`
: This parameter is specified when you are using an Amazon Elastic File System file system for task storage.

: **Field**: `volumes_efs_volume_configurations`

`volumes (efs_volume_configuration (file_system_id))`
: The Amazon EFS file system ID to use.

: **Field**: `volumes_efs_volume_configuration_file_system_ids`

`volumes (efs_volume_configuration (root_directory))`
: The directory within the Amazon EFS file system to mount as the root directory inside the host.

: **Field**: `volumes_efs_volume_configuration_root_directories`

`volumes (efs_volume_configuration (transit_encryption))`
: Whether or not to enable encryption for Amazon EFS data in transit between the Amazon ECS host and the Amazon EFS server. Transit encryption must be enabled if Amazon EFS IAM authorization is used.

: **Field**: `volumes_efs_volume_configuration_transit_encryptions`

`volumes (efs_volume_configuration (transit_encryption_port))`
: The port to use when sending encrypted data between the Amazon ECS host and the Amazon EFS server.

: **Field**: `volumes_efs_volume_configuration_transit_encryption_ports`

`volumes (efs_volume_configuration (authorization_config)`
: The authorization configuration details for the Amazon EFS file system.

: **Field**: `volumes_efs_volume_configuration_authorization_configs`

`volumes (efs_volume_configuration (authorization_config (access_point_id))`
: The Amazon EFS access point ID to use.

: **Field**: `volumes_efs_volume_configuration_authorization_config_access_point_ids`

`volumes (efs_volume_configuration (authorization_config (iam))`
: The Amazon EFS IAM to use.

: **Field**: `volumes_efs_volume_configuration_authorization_config_iams`

`volumes (fsx_windows_file_server_volume_configuration)`
: This parameter is specified when you are using Amazon FSx for Windows File Server file system for task storage.

: **Field**: `volumes_fsx_windows_file_server_volume_configurations`

`volumes (fsx_windows_file_server_volume_configuration (file_system_id))`
: The Amazon FSx for Windows File Server file system ID to use.

: **Field**: `volumes_fsx_windows_file_server_volume_configurations_file_system_ids`

`volumes (fsx_windows_file_server_volume_configuration (root_directory))`
: The directory within the Amazon FSx for Windows File Server file system to mount as the root directory inside the host.

: **Field**: `volumes_fsx_windows_file_server_volume_configurations_root_directories`

`volumes (fsx_windows_file_server_volume_configuration (authorization_config))`
: The authorization configuration details for the Amazon FSx for Windows File Server file system.

: **Field**: `volumes_fsx_windows_file_server_volume_configurations_authorization_configs`

`volumes (fsx_windows_file_server_volume_configuration (authorization_config (credentials_parameter)))`
: The authorization credential option to use.

: **Field**: `volumes_fsx_windows_file_server_volume_configurations_authorization_configs_credentials_parameters`

`volumes (fsx_windows_file_server_volume_configuration (authorization_config (domain)))`
: A fully qualified domain name hosted by an AWS Directory Service Managed Microsoft AD (Active Directory) or self-hosted AD on Amazon EC2.

: **Field**: `volumes_fsx_windows_file_server_volume_configurations_authorization_configs_domains`

`status`
: The status of the task definition.

: **Field**: `status`

`requires_attributes`
: The container instance attributes required by your task.

: **Field**: `requires_attributes`

`requires_attributes (name)`
: The name of the attribute.

: **Field**: `requires_attributes_names`

`requires_attributes (value)`
: The value of the attribute.

: **Field**: `requires_attributes_values`

`requires_attributes (target_type)`
: The type of the target with which to attach the attribute.

: **Field**: `requires_attributes_target_types`

`requires_attributes (target_id)`
: The ID of the target.

: **Field**: `requires_attributes_targets`

`placement_constraints`
: An array of placement constraint objects to use for tasks.

: **Field**: `placement_constraints`

`placement_constraints (type)`
: The type of constraint.

: **Field**: `placement_constraints_types`

`placement_constraints (expression)`
: The expression of constraint.

: **Field**: `placement_constraints_expressions`

`compatibilities`
: The task launch types the task definition validated against during task definition registration.

: **Field**: `compatibilities`

`requires_compatibilities`
: The task launch types the task definition was validated against.

: **Field**: `FieldName`

`cpu`
: The number of CPU units used by the task.

: **Field**: `cpu`

`memory`
: The amount (in MiB) of memory used by the task.

: **Field**: `memory`

`inference_accelerators`
: The Elastic Inference accelerator associated with the task.

: **Field**: `inference_accelerators`

`inference_accelerators (device_name)`
: The Elastic Inference accelerator device name.

: **Field**: `inference_accelerators_device_names`

`inference_accelerators (device_type)`
: The Elastic Inference accelerator type to use.

: **Field**: `inference_accelerators_device_types`

`pid_mode`
: The process namespace to use for the containers in the task. The valid values are `host` or `task`.

: **Field**: `pid_mode`

`ipc_mode`
: The IPC resource namespace to use for the containers in the task. The valid values are `host`, `task`, or `none`.

: **Field**: `ipc_mode`

`proxy_configuration`
: The configuration details for the App Mesh proxy.

: **Field**: `proxy_configuration`

`proxy_configuration (type)`
: The proxy type. The only supported value is `APPMESH`.

: **Field**: `proxy_configuration_types`

`proxy_configuration (container_name)`
: The name of the container that will serve as the App Mesh proxy.

: **Field**: `proxy_configuration_container_names`

`proxy_configuration (properties)`
: The set of network configuration parameters to provide the Container Network Interface (CNI) plugin, specified as key-value pairs.

: **Field**: `proxy_configuration_properties`

`proxy_configuration (properties (name))`
: The name of the key-value pair.

: **Field**: `proxy_configuration_properties_names`

`proxy_configuration (properties (value))`
: The value of the key-value pair.

: **Field**: `proxy_configuration_properties_values`

`tags`
: The tags of the task definition.

: **Field**: `tags`

## Examples

**Ensure a task definition ARN is available.**

```ruby
describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
  its('task_definition_arn') { should eq 'arn:aws:ecs:REGION:AWS_ACCOUNT_ID:task-definition/TASK_DEFINITION_ID' }
end
```

**Verify the amount of memory for a task definition.**

```ruby
describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
    its('memory') { should eq 500 }
end
```

**Verify the name of a task definition.**

```ruby
describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
    its('container_definitions_names') { should include 'Task_Definition_Container_Name' }    
end
```

**Verify the cpu of a task definition.**

```ruby
describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
    its('container_definitions_cpus') { should include 10 }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the task definition is available.

```ruby
describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ECS:Client:DescribeTaskDefinitionResponse" %}}
