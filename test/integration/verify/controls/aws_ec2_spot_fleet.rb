aws_spot_fleet_request_id = input(:aws_spot_fleet_request_id, value: '', description: '')
aws_spot_fleet_request_iam_fleet_role = input(:aws_spot_fleet_request_iam_fleet_role, value: '', description: '')

control 'aws-ec2-spot-fleet-1.0' do
  title 'Test a singular resource of the aws ec2 spot fleet.'

  describe aws_ec2_spot_fleet(spot_fleet_request_id: aws_spot_fleet_request_id) do
    it { should exist }
  end

  describe aws_ec2_spot_fleet(spot_fleet_request_id: aws_spot_fleet_request_id) do
    its('activity_status') { should eq 'error' }

    its('spot_fleet_request_config.on_demand_allocation_strategy') { should eq 'lowestPrice' }
    its('spot_fleet_request_config.iam_fleet_role') { should eq aws_spot_fleet_request_iam_fleet_role }

    its('spot_fleet_request_config.launch_specifications') { should be_empty }
    its('spot_fleet_request_config.launch_template_configs') { should_not be_empty }

    its('spot_fleet_request_config.target_capacity') { should eq 2  }
    its('spot_fleet_request_config.terminate_instances_with_expiration') { should eq false }
    its('spot_fleet_request_config.type') { should eq 'maintain' }
    its('spot_fleet_request_config.replace_unhealthy_instances') { should eq false }
    its('spot_fleet_request_config.instance_interruption_behavior') { should eq 'terminate' }

    its('spot_fleet_request_config.load_balancers_config.classic_load_balancers_config.classic_load_balancers') { should be_empty }
    its('spot_fleet_request_config.load_balancers_config.target_groups_config.target_groups') { should be_empty }

    its('spot_fleet_request_config.instance_pools_to_use_count') { should eq 1 }
    its('spot_fleet_request_config.tag_specifications') { should be_empty }
    its('spot_fleet_request_state') { should eq 'active' }
    its('tags') { should be_empty }
  end
end
