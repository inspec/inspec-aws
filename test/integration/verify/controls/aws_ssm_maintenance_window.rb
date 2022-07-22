aws_ssm_maintenance_window_id = input(:aws_ssm_maintenance_window_id, value: '', description: '')

control 'aws-ssm-maintenance-window-1.0' do
  impact 1.0
  title 'Test the properties of the ses maintenance window.'

  describe aws_ssm_maintenance_window(window_id: aws_ssm_maintenance_window_id) do
    it { should exist }
  end

  describe aws_ssm_maintenance_window(window_id: aws_ssm_maintenance_window_id) do
    its('window_id') { should eq aws_ssm_maintenance_window_id }
    its('name') { should eq 'maintenance-window-application' }
    its('description') { should be_empty }
    its('start_date') { should be_empty }
    its('end_date') { should be_empty }
    its('schedule') { should eq 'cron(0 16 ? * TUE *)' }
    its('schedule_timezone') { should be_empty }
    its('schedule_offset') { should be_empty }
    its('duration') { should eq 3 }
    its('cutoff') { should eq 1 }
    its('enabled') { should eq true }
  end

  describe aws_ssm_maintenance_window(window_id: 'dummy') do
    it { should_not exist }
  end
end
