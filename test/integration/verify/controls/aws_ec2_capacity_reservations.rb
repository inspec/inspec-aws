aws_ec2_capacity_reservation_id = input(:aws_ec2_capacity_reservation_id, value: '', description: '')
aws_ec2_capacity_reservation_instance_type = input(:aws_ec2_capacity_reservation_instance_type, value: '', description: '')
aws_ec2_capacity_reservation_instance_platform = input(:aws_ec2_capacity_reservation_instance_platform, value: '=', description: '')
aws_ec2_capacity_reservation_availability_zone = input(:aws_ec2_capacity_reservation_availability_zone, value: '', description: '')
aws_ec2_capacity_reservation_instance_arn = input(:aws_ec2_capacity_reservation_instance_arn, value: '', description: '')

control 'aws-ec2-capacity-reservations-1.0' do
  impact 1.0
  title 'Describes one or more of your Capacity Reservations.'

  describe aws_ec2_capacity_reservations do
    it { should exist }
  end

  describe aws_ec2_capacity_reservations do
    its('capacity_reservation_ids') { should include aws_ec2_capacity_reservation_id }
    its('owner_ids') { should_not include '1234567890' }
    its('capacity_reservation_arns') { should include aws_ec2_capacity_reservation_instance_arn }
    its('availability_zone_ids') { should include 'use2-az1' }
    its('instance_types') { should include aws_ec2_capacity_reservation_instance_type }
    its('instance_platforms') { should include aws_ec2_capacity_reservation_instance_platform }
    its('availability_zones') { should include aws_ec2_capacity_reservation_availability_zone }
    its('tenancies') { should include 'default' }
    its('total_instance_counts') { should include 1 }
    its('ebs_optimized') { should include false }
    its('ephemeral_storages') { should include false }
    its('states') { should include 'active' }
    its('start_dates') { should_not include Time.parse('2021-09-20 13:10:26.000000000 +0000') }
    its('end_date_types') { should include 'unlimited' }
    its('instance_match_criterias') { should include 'open' }
    its('create_dates') { should_not include Time.parse('2021-09-20 13:10:26.000000000 +0000') }
    its('tags') { should_not be_empty }
  end
end