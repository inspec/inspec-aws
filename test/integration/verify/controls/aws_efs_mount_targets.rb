describe aws_efs_mount_targets(file_system_id: "fs-e2e41199") do
    it { should exist }
end

describe aws_efs_mount_targets(file_system_id: "fs-e2e41199") do
    its('owner_ids') { should include "112758395563" }
    its('mount_target_ids') { should include "fsmt-38ccd941" }
    its('file_system_ids') { should include "fs-e2e41199" }
    its('subnet_ids') { should include "subnet-700ff218" }
    its('life_cycle_states') { should include "available" }
    its('ip_addresses') { should include "172.31.8.66" }
    its('network_interface_ids') { should include "eni-0c0e826f4942ac892" }
    its('availability_zone_ids') { should include "use2-az1" }
    its('availability_zone_names') { should include "us-east-2a" }
    its('vpc_ids') { should include "vpc-6d9d7505" }
end

describe aws_efs_mount_targets(file_system_id: "dummy") do
    it { should_not exist }
end