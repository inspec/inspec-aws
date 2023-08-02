
control 'aws-ec2-capacity-reservations-1.0' do
  title 'Describes one or more of your Capacity Reservations.'

  describe aws_ec2_capacity_reservations do
    it { should exist }
  end

  describe aws_ec2_capacity_reservations do
    its('tenancies') { should_not include 'default' }
    its('total_instance_counts') { should include 1 }
    its('ebs_optimized') { should include false }
    its('ephemeral_storages') { should include false }
    its('states') { should include 'active' }
    its('end_date_types') { should include 'unlimited' }
    its('instance_match_criterias') { should include 'open' }
    its('tags') { should_not be_empty }
  end
end