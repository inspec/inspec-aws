describe aws_efs_mount_target(mount_target_id: "fsmt-38ccd941") do
    it { should exist }
end

describe aws_efs_mount_target(mount_target_id: "fsmt-38ccd941")  do
    its('owner_id') { should eq "112758395563" }
    its('mount_target_id') { should eq "fsmt-38ccd941" }
    its('file_system_id') { should eq "fs-e2e41199" }
    its('subnet_id') { should eq "subnet-700ff218" }
    its('life_cycle_state') { should eq "available" }
    its('ip_address') { should eq "172.31.8.66" }
    its('network_interface_id') { should eq "eni-0c0e826f4942ac892" }
    its('availability_zone_id') { should eq "use2-az1" }
    its('availability_zone_name') { should eq "us-east-2a" }
    its('vpc_id') { should eq "vpc-6d9d7505" }
end