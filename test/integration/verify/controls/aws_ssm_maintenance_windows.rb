aws_ssm_maintenance_window_id = input(:aws_ssm_maintenance_window_id, value: '', description: '')

control 'aws-ssm-maintenance-windows-1.0' do
  title 'Test the properties of the ses maintenance windows.'

  describe aws_ssm_maintenance_windows do
    it { should exist }
  end

  describe aws_ssm_maintenance_windows do
    its('window_ids') { should include aws_ssm_maintenance_window_id }
    its('names') { should include 'maintenance-window-application' }
    its('descriptions') { should_not be_empty }
    its('enabled') { should include true }
    its('durations') { should include 3 }
    its('cutoffs') { should include 1 }
    its('schedules') { should include 'cron(0 16 ? * TUE *)' }
    its('schedule_timezones') { should_not be_empty }
    its('schedule_offsets') { should_not be_empty }
    its('end_dates') { should_not be_empty }
    its('start_dates') { should_not be_empty }
    its('next_execution_times') { should_not be_empty }
  end
end
