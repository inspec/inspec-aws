aws_mount_target_mt_id = input(:aws_mount_target_mt_id, value: '', description: '')
aws_file_system_mt_id = input(:aws_file_system_mt_id, value: '', description: '')
aws_subnet_mt_id = input(:aws_subnet_mt_id, value: '', description: '')
aws_vpc_mt_id = input(:aws_vpc_mt_id, value: '', description: '')

control 'aws-efs-mount-targets-1.0' do
  title 'Ensure AWS EFS Mount Targets has the correct properties.'
  
  describe aws_efs_mount_targets(file_system_id: aws_file_system_mt_id) do
    it { should exist }
  end
  
  describe aws_efs_mount_targets(file_system_id: aws_file_system_mt_id) do
    its('owner_ids') { should include '112758395563' }
    its('mount_target_ids') { should include aws_mount_target_mt_id }
    its('file_system_ids') { should include aws_file_system_mt_id }
    its('subnet_ids') { should include aws_subnet_mt_id }
    its('life_cycle_states') { should include 'available' }
    its('ip_addresses') { should include '10.0.1.150' }
    its('network_interface_ids') { should include 'eni-007d6a05a0f62a93b' }
    its('availability_zone_ids') { should include 'use2-az1' }
    its('availability_zone_names') { should include 'us-east-2a' }
    its('vpc_ids') { should include aws_vpc_mt_id }
  end
  
  describe aws_efs_mount_targets(file_system_id: 'dummy') do
    it { should_not exist }
  end
end
