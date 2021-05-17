describe aws_efs_mount_targets do
    it { should exist }
end

describe aws_efs_mount_targets do
    its('owner_ids') { should include "" }
    its('mount_target_ids') { should include "" }
    its('file_system_ids') { should include "" }
    its('subnet_ids') { should include "" }
    its('life_cycle_states') { should include "" }
    its('ip_addresses') { should include "" }
    its('network_interface_ids') { should include "" }
    its('availability_zone_ids') { should include "" }
    its('availability_zone_names') { should include "" }
    its('vpc_ids') { should include "" }
end