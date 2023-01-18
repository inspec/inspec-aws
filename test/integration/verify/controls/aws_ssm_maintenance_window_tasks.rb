aws_ssm_maintenance_window_id = input(:aws_ssm_maintenance_window_id, value: '', description: '')
aws_ssm_maintenance_window_task_id = input(:aws_ssm_maintenance_window_task_id, value: '', description: '')
aws_ssm_maintenance_window_task_task_arn = input(:aws_ssm_maintenance_window_task_task_arn, value: '', description: '')
aws_ssm_maintenance_window_task_task_type = input(:aws_ssm_maintenance_window_task_task_type, value: '', description: '')

control 'aws-ssm-maintenance-window-tasks-1.0' do
  title 'Test the properties of the ssm maintenance window tasks.'

  describe aws_ssm_maintenance_window_tasks(window_id: aws_ssm_maintenance_window_id) do
    it { should exist }
  end

  describe aws_ssm_maintenance_window_tasks(window_id: aws_ssm_maintenance_window_id) do
    its('window_ids') { should include aws_ssm_maintenance_window_id }
    its('window_task_ids') { should include aws_ssm_maintenance_window_task_id }
    its('task_arns') { should include aws_ssm_maintenance_window_task_task_arn }
    its('types') { should include aws_ssm_maintenance_window_task_task_type }

    its('targets') { should_not be_empty }

    its('task_parameters') { should_not be_empty }

    its('priorities') { should include 1 }

    its('logging_infos') { should_not be_empty }

    its('max_concurrencies') { should include '2' }
    its('max_errors') { should include '1' }
    its('names') { should include nil }
    its('descriptions') { should_not be_empty }
    its('cutoff_behaviors') { should_not be_empty }
  end

  describe aws_ssm_maintenance_window_tasks(window_id: 'dummy') do
    it { should_not exist }
  end
end
