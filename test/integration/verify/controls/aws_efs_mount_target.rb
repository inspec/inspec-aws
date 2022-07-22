aws_mount_target_mt_id = input(:aws_mount_target_mt_id, value: '', description: '')
aws_file_system_mt_id = input(:aws_file_system_mt_id, value: '', description: '')
aws_subnet_mt_id = input(:aws_subnet_mt_id, value: '', description: '')
aws_vpc_mt_id = input(:aws_vpc_mt_id, value: '', description: '')

control 'aws-efs-mount-target-1.0' do
  impact 1.0
  title 'Ensure AWS EFS Mount Target has the correct properties.'
  
  describe aws_efs_mount_target(mount_target_id: aws_mount_target_mt_id) do
    it { should exist }
  end
  
  describe aws_efs_mount_target(mount_target_id: aws_mount_target_mt_id)  do
    its('owner_id') { should eq '112758395563' }
    its('mount_target_id') { should eq aws_mount_target_mt_id }
    its('file_system_id') { should eq aws_file_system_mt_id }
    its('subnet_id') { should eq aws_subnet_mt_id }
    its('life_cycle_state') { should eq 'available' }
    its('ip_address') { should eq '10.0.1.150' }
    its('network_interface_id') { should eq 'eni-007d6a05a0f62a93b' }
    its('availability_zone_id') { should eq 'use2-az1' }
    its('availability_zone_name') { should eq 'us-east-2a' }
    its('vpc_id') { should eq aws_vpc_mt_id }
  end
  
  describe aws_efs_mount_target(mount_target_id: 'dummy') do
    it { should_not exist }
  end
end