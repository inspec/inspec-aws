aws_spot_fleet_request_id = input(:aws_spot_fleet_request_id, value: '', description: '')

control 'aws-ec2-spot-fleets-1.0' do
  title 'Test a plural resource of the aws ec2 spot fleet.'

  describe aws_ec2_spot_fleets do
    it { should exist }
  end

  describe aws_ec2_spot_fleets do
    its('activity_statuses') { should include 'error' }
    its('create_times') { should_not be_empty }
    its('spot_fleet_request_configs') { should_not be_empty }
    its('spot_fleet_request_ids') { should include aws_spot_fleet_request_id }
    its('spot_fleet_request_states') { should include 'active' }
    its('tags') { should_not be_empty }
  end
end
