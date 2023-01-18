aws_ec2_fleet_id = input(:aws_ec2_fleet_id, value: '', description: '')

control 'aws-ec2-hosts-1.0' do
  title 'Describes the specified Dedicated Hosts or all your Dedicated Hosts.'

  describe aws_ec2_hosts do
    it { should exist }
  end

  describe aws_ec2_hosts do
    its('auto_placements') { should include 'on' }
    its('availability_zones') { should include 'us-east-2a' }
    its('available_capacities') { should_not be_empty }
    its('client_tokens') { should_not be_empty }
    its('host_ids') { should include aws_ec2_fleet_id }
    its('host_properties') { should_not be_empty }
    its('instances') { should_not be_empty }
    its('states') { should include 'available' }
    its('allocation_times') { should_not be_empty }
    its('tags') { should_not be_empty }
    its('host_recoveries') { should include 'on' }
    its('allows_multiple_instance_types') { should include 'on' }
    its('owner_ids') { should_not include '1234567890' }
    its('availability_zone_ids')  { should include 'use2-az1' }
    its('member_of_service_linked_resource_groups') { should include false }
  end
end
