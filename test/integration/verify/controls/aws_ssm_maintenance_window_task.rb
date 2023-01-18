aws_ssm_maintenance_window_id = input(:aws_ssm_maintenance_window_id, value: '', description: '')
aws_ssm_maintenance_window_task_id = input(:aws_ssm_maintenance_window_task_id, value: '', description: '')
aws_ssm_maintenance_window_task_task_arn = input(:aws_ssm_maintenance_window_task_task_arn, value: '', description: '')
aws_ssm_maintenance_window_task_task_type = input(:aws_ssm_maintenance_window_task_task_type, value: '', description: '')

control 'aws-ssm-maintenance-window-task-1.0' do
  title 'Test the properties of the ssm maintenance window task.'

  describe aws_ssm_maintenance_window_task(window_id: aws_ssm_maintenance_window_id, window_task_id: aws_ssm_maintenance_window_task_id) do
    it { should exist }
  end

  describe aws_ssm_maintenance_window_task(window_id: aws_ssm_maintenance_window_id, window_task_id: aws_ssm_maintenance_window_task_id) do
    its('window_id') { should eq aws_ssm_maintenance_window_id }
    its('window_task_id') { should eq aws_ssm_maintenance_window_task_id }
    its('task_arn') { should eq aws_ssm_maintenance_window_task_task_arn }
    its('type') { should eq aws_ssm_maintenance_window_task_task_type }

    its('targets') { should_not be_empty }
    its('target_keys') { should include 'InstanceIds' }
    its('target_values') { should_not be_empty }

    its('task_parameters') { should be_empty }

    its('priority') { should eq 1 }

    its('logging_info.s3_bucket_name') { should be_empty }
    its('logging_info.s3_key_prefix') { should be_empty }
    its('logging_info.s3_region') { should be_empty }

    its('max_concurrency') { should eq '2' }
    its('max_errors') { should eq '1' }
    its('name') { should eq nil }
    its('description') { should be_empty }
    its('cutoff_behavior') { should be_empty }
  end
end
