control 'aws-application-autoscaling-scalable-target' do
  title 'Ensure Application AutoScaling Target resource has the correct properties.'

  describe aws_application_autoscaling_scalable_target( service_namespace: 'dynamodb' ) do
    it { should exist }
  end

  describe aws_application_autoscaling_scalable_target( service_namespace: 'dynamodb' ) do
    its('service_namespace') { should eq 'dynamodb' }
    its('resource_id') { should eq 'table/GameScores' }
    its('scalable_dimension') { should eq 'dynamodb:table:ReadCapacityUnits' }
    its('min_capacity') { should eq 5 }
    its('max_capacity') { should eq 100 }
    its('role_arn') { should_not be_empty }
    its('suspended_state.dynamic_scaling_in_suspended') { should eq false }
    its('suspended_state.dynamic_scaling_out_suspended') { should eq false }
    its('suspended_state.scheduled_scaling_suspended') { should eq false }
  end
end
