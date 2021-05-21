aws_name = attribute("aws_name", default: "", description: "")
aws_state = attribute("aws_state", default: "", description: "")
aws_description = attribute("aws_description", default: "", description: "")
aws_creation_time = attribute("aws_creation_time", default: "", description: "")
aws_configuration_result_configuration = attribute("aws_configuration_result_configuration", default: "", description: "")
aws_configuration_enforce_work_group_configuration = attribute("aws_configuration_enforce_work_group_configuration", default: "", description: "")
aws_configuration_publish_cloud_watch_metrics_enabled = attribute("aws_configuration_publish_cloud_watch_metrics_enabled", default: "", description: "")
aws_configuration_bytes_scanned_cutoff_per_query = attribute("aws_configuration_bytes_scanned_cutoff_per_query", default: "", description: "")
aws_configuration_requester_pays_enabled = attribute("aws_configuration_requester_pays_enabled", default: "", description: "")
aws_configuration_engine_version_selected_engine_version = attribute("aws_configuration_engine_version_selected_engine_version", default: "", description: "")
aws_configuration_engine_version_effective_engine_version = attribute("aws_configuration_engine_version_effective_engine_version", default: "", description: "")


describe aws_athena_work_group(work_group: 'test1') do
  it { should exist }
  its('name') { should eq aws_name }
  its('state') { should eq aws_state }
  its('description') { should eq aws_description }
  # its('creation_time') { should be_empty }
  its('configuration.result_configuration') { should be_empty }
  its('configuration.enforce_work_group_configuration') { should eq aws_configuration_enforce_work_group_configuration }
  its('configuration.publish_cloud_watch_metrics_enabled') { should eq aws_configuration_publish_cloud_watch_metrics_enabled }
  its('configuration.bytes_scanned_cutoff_per_query') { should be_empty }
  its('configuration.requester_pays_enabled') { should eq aws_configuration_requester_pays_enabled }
  its('configuration.engine_version.selected_engine_version') { should eq aws_configuration_engine_version_selected_engine_version }
  its('configuration.engine_version.effective_engine_version') { should eq aws_configuration_engine_version_effective_engine_version }
end