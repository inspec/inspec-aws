aws_ec2_fleet_id = input(:aws_ec2_fleet_id, value: '', description: '')

control 'aws-ec2-host-1.0' do
  impact 1.0
  title 'Describes the specified Dedicated Hosts or all your Dedicated Hosts.'

  describe aws_ec2_host(host_id: aws_ec2_fleet_id) do
    it { should exist }
  end

  describe aws_ec2_host(host_id: aws_ec2_fleet_id) do
    its('auto_placement') { should eq 'on' }
    its('availability_zone') { should eq 'us-east-2a' }
    its('available_capacity.available_instance_capacity') { should_not be_empty }
    its('available_capacity.available_v_cpus') { should eq 16 }
    its('client_token') { should be_empty }
    its('host_id') { should eq aws_ec2_fleet_id }
    its('host_properties.cores') { should eq 16 }
    its('host_properties.instance_type') { should be_empty }
    its('host_properties.instance_family') { should eq 'a1' }
    its('host_properties.sockets') { should eq 1 }
    its('host_properties.total_v_cpus') { should eq 16 }
    its('host_reservation_id') { should be_empty }
    its('instances') { should be_empty }
    its('state') { should eq 'available' }
    its('allocation_time') { should_not eq Time.parse('2021-05-20 11:35:12 UTC') }
    its('release_time') { should be_empty }
    its('tags') { should_not be_empty }
    its('host_recovery') { should eq 'on' }
    its('allows_multiple_instance_types') { should eq 'on' }
    its('owner_id') { should eq '1234567890' }
    its('availability_zone_id') { should eq 'use2-az1' }
    its('member_of_service_linked_resource_group') { should eq false }
  end
end