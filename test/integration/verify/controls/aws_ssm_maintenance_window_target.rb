aws_ssm_maintenance_window_id = input(:aws_ssm_maintenance_window_id, value: '', description: '')
aws_ssm_maintenance_window_target_description = input(:aws_ssm_maintenance_window_target_description, value: '', description: '')
aws_ssm_maintenance_window_target_id = input(:aws_ssm_maintenance_window_target_id, value: '', description: '')
aws_ssm_maintenance_window_target_name = input(:aws_ssm_maintenance_window_target_id, value: '', description: '')

control 'aws-ssm-maintenance-window-target-1.0' do
  title 'Test the properties of the ssm maintenance window target.'

  describe aws_ssm_maintenance_window_target(window_id: aws_ssm_maintenance_window_id, window_target_id: aws_ssm_maintenance_window_target_id) do
    it { should exist }
  end

  describe aws_ssm_maintenance_window_target(window_id: aws_ssm_maintenance_window_id, window_target_id: aws_ssm_maintenance_window_target_id) do
    its('window_id') { should eq aws_ssm_maintenance_window_id }
    its('window_target_id') { should eq aws_ssm_maintenance_window_target_id }
    its('resource_type') { should eq 'INSTANCE' }

    its('targets') { should_not be_empty }
    its('target_keys') { should include 'tag:Name' }

    its('owner_information') { should be_empty }
    its('name') { should eq aws_ssm_maintenance_window_target_name }
    its('description') { should eq aws_ssm_maintenance_window_target_description }
  end

  describe aws_ssm_maintenance_window_target(window_id: 'dummy', window_target_id: 'dummy') do
    it { should_not exist }
  end
end
