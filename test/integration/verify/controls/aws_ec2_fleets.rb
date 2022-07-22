aws_ec2_fleet_id = input(:aws_ec2_fleet_id, value: '', description: '')

control 'aws-ec2-fleets-1.0' do
    impact 1.0
    title 'Describes the specified EC2 Fleets or all of your EC2 Fleets.'

    describe aws_ec2_fleets do
      it { should exist }
    end

    describe aws_ec2_fleets do
      its('activity_statuses') { should_not be_empty }
      its('create_times') { should include Time.parse('2021-09-20 14:18:26 UTC') }
      its('fleet_ids') { should include aws_ec2_fleet_id }
      its('fleet_states') { should include 'deleted' }
      its('client_tokens') { should_not be_empty }
      its('excess_capacity_termination_policies') { should include 'termination' }
      its('fulfilled_capacities') { should_not be_empty }
      its('fulfilled_on_demand_capacities') { should_not be_empty }
      its('launch_template_configs') { should_not be_empty }
      its('target_capacity_specifications') { should_not be_empty }
      its('terminate_instances_with_expiration') { should include false }
      its('types') { should include 'maintain' }
      its('valid_from') { should_not be_empty }
      its('valid_until') { should_not be_empty }
      its('replace_unhealthy_instances') { should include false }
      its('spot_options') { should_not be_empty }
      its('on_demand_options') { should_not be_empty }
      its('tags') { should_not be_empty }
      its('errors') { should_not be_empty }
      its('instances') { should_not be_empty }
      its('contexts') { should_not be_empty }
    end
end