aws_athena_workgroup = input(:aws_athena_workgroup, value: '', description: '')
aws_state = input(:aws_athena_workgroup_state, value: '', description: '')
aws_description = input(:aws_athena_workgroup_description, value: '', description: '')
aws_configuration_enforce_work_group_configuration = input(:aws_enforce_workgroup_configuration, value: '', description: '')
aws_configuration_publish_cloud_watch_metrics_enabled = input(:aws_publish_cloudwatch_metrics_enabled, value: '', description: '')

control 'aws-athena-work-group-1.0' do
  title 'Test the properties of Athena Work Group.'

  describe aws_athena_work_group(work_group: aws_athena_workgroup) do
    it { should exist }
  end

  describe aws_athena_work_group(work_group: aws_athena_workgroup) do
    its('name') { should eq aws_athena_workgroup }
    its('state') { should eq aws_state }
    its('description') { should eq aws_description }
    its('configuration.enforce_work_group_configuration') { should eq aws_configuration_enforce_work_group_configuration }
    its('configuration.publish_cloud_watch_metrics_enabled') { should eq aws_configuration_publish_cloud_watch_metrics_enabled }
    its('creation_time') { should be <= Time.now }
  end
end
