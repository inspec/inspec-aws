aws_ec2_capacity_reservation_id = input(:aws_ec2_capacity_reservation_id, value: '', description: '')
aws_ec2_capacity_reservation_instance_type = input(:aws_ec2_capacity_reservation_instance_type, value: '', description: '')
aws_ec2_capacity_reservation_instance_platform = input(:aws_ec2_capacity_reservation_instance_platform, value: '=', description: '')
aws_ec2_capacity_reservation_availability_zone = input(:aws_ec2_capacity_reservation_availability_zone, value: '', description: '')
aws_ec2_capacity_reservation_instance_arn = input(:aws_ec2_capacity_reservation_instance_arn, value: '', description: '')

control 'aws-ec2-capacity-reservation-1.0' do
  title 'Describes one or more of your Capacity Reservations.'

  describe aws_ec2_capacity_reservation(capacity_reservation_id: aws_ec2_capacity_reservation_id) do
    it { should exist }
  end

  describe aws_ec2_capacity_reservation(capacity_reservation_id: aws_ec2_capacity_reservation_id) do
    its('capacity_reservation_id') { should eq aws_ec2_capacity_reservation_id }
    its('owner_id') { should_not eq '1234567890' }
    its('capacity_reservation_arn') { should eq aws_ec2_capacity_reservation_instance_arn }
    its('availability_zone_id') { should eq 'use2-az1' }
    its('instance_type') { should eq aws_ec2_capacity_reservation_instance_type }
    its('instance_platform') { should eq aws_ec2_capacity_reservation_instance_platform }
    its('availability_zone') { should eq aws_ec2_capacity_reservation_availability_zone }
    its('tenancy') { should eq 'default' }
    its('total_instance_count') { should eq 1 }
    its('ebs_optimized') { should eq false }
    its('ephemeral_storage') { should eq false }
    its('state') { should eq 'active' }
    its('start_date') { should_not eq Time.parse('2021-09-20 13:10:26.000000000 +0000') }
    its('end_date_type') { should eq 'unlimited' }
    its('instance_match_criteria') { should eq 'open' }
    its('create_date') { should_not eq Time.parse('2021-09-20 13:10:26.000000000 +0000') }
    its('tags') { should be_empty }
  end
end
