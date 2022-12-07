aws_ssm_resource_data_sync_name = input(:aws_ssm_resource_data_sync_name, value: '', description: '')

control 'aws_ssm_resource_data_syncs-1.0' do
  impact 1.0
  title 'Test the properties of the ssm resource data syncs.'

  describe aws_ssm_resource_data_syncs do
    it { should exist }
  end

  describe aws_ssm_resource_data_syncs do
    its('sync_names') { should include aws_ssm_resource_data_sync_name }
    its('sync_types') { should_not be_empty }
    its('sync_sources') { should_not be_empty }
    its('s3_destinations') { should_not be_empty }
    its('last_statuses') { should include 'Successful' }
    its('last_sync_status_messages') { should include 'The sync was successfully completed' }
  end
end
