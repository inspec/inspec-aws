aws_ec2_fleet_id = input(:aws_ec2_fleet_id, value: '', description: '')

control 'aws-ec2-fleet-1.0' do
  impact 1.0
  title 'Describes the specified EC2 Fleets or all of your EC2 Fleets.'

  describe aws_ec2_fleet(fleet_id: aws_ec2_fleet_id) do
    it { should exist }
  end

  describe aws_ec2_fleet(fleet_id: aws_ec2_fleet_id) do
    its('activity_status') { should be_empty }
    its('create_time') { should eq Time.parse('2021-09-20 14:18:26 UTC') }
    its('fleet_id') { should eq aws_ec2_fleet_id }
    its('fleet_state') { should eq 'deleted' }
    its('client_token') { should be_empty }
    its('excess_capacity_termination_policy') { should eq 'termination' }
    its('fulfilled_capacity') { should be_empty }
    its('fulfilled_on_demand_capacity') { should be_empty }
    its('launch_template_configs') { should_not be_empty }
    its('target_capacity_specification.total_target_capacity') { should eq 5 }
    its('target_capacity_specification.on_demand_target_capacity') { should eq 0 }
    its('target_capacity_specification.spot_target_capacity') { should eq 5 }
    its('target_capacity_specification.default_target_capacity_type') { should eq 'spot' }
    its('terminate_instances_with_expiration') { should eq false }
    its('type') { should eq 'maintain' }
    its('valid_from') { should be_empty }
    its('valid_until') { should be_empty }
    its('replace_unhealthy_instances') { should eq false }
    its('spot_options.allocation_strategy') { should eq 'lowestPrice' }
    its('spot_options.maintenance_strategies.capacity_rebalance.replacement_strategy') { should be_empty }
    its('spot_options.instance_interruption_behavior') { should eq 'terminate' }
    its('spot_options.instance_pools_to_use_count') { should eq 1 }
    its('spot_options.single_instance_type') { should be_empty }
    its('spot_options.single_availability_zone') { should be_empty }
    its('spot_options.min_target_capacity') { should be_empty }
    its('spot_options.max_total_price') { should be_empty }
    its('on_demand_options.allocation_strategy') { should eq 'lowestPrice' }
    its('on_demand_options.capacity_reservation_options.usage_strategy') { should be_empty }
    its('on_demand_options.single_instance_type') { should be_empty }
    its('on_demand_options.single_availability_zone') { should be_empty }
    its('on_demand_options.min_target_capacity') { should be_empty }
    its('on_demand_options.max_total_price') { should be_empty }
    its('tags') { should be_empty }
    its('errors') { should be_empty }
    its('instances') { should be_empty }
    its('context') { should be_empty }
  end
end