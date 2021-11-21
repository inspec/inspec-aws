aws_athena_workgroup= attribute("aws_athena_workgroup", value: "", description: "")
aws_state = attribute("aws_athena_workgroup_state", value: "", description: "")
aws_description = attribute("aws_athena_workgroup_description", value: "", description: "")
aws_configuration_enforce_work_group_configuration = attribute("aws_enforce_workgroup_configuration", value: "", description: "")
aws_configuration_publish_cloud_watch_metrics_enabled = attribute("aws_publish_cloudwatch_metrics_enabled", value: "", description: "")

  describe aws_athena_work_group(work_group: aws_athena_workgroup) do
    it { should exist }
    its('name') { should eq aws_athena_workgroup }
    its('state') { should eq aws_state }
    its('description') { should eq aws_description }
    its('configuration.enforce_work_group_configuration') { should eq aws_configuration_enforce_work_group_configuration }
    its('configuration.publish_cloud_watch_metrics_enabled') { should eq aws_configuration_publish_cloud_watch_metrics_enabled }
    its('creation_time') { should be <= Time.now }
  end
