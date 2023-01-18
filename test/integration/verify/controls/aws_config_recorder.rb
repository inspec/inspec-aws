title 'Test single AWS Config Recorder'

aws_config_recorder_role_arn = input(:aws_config_recorder_role_arn, value: '', description: 'The AWS Config Recorder ARN.')
aws_configuration_recorder_name = input(:aws_configuration_recorder_name, value: '', description: 'The AWS Config Recorder name.')
aws_create_configuration_recorder = input(:aws_create_configuration_recorder, value: 0, description:'Flag to enable configuration recorder controls since there can only be one per region of these.')

control 'aws-config-recorder-1.0' do
  only_if { aws_create_configuration_recorder.to_i == 1 }
  title 'Ensure AWS Config Recorder has the correct properties.'

  describe aws_config_recorder do
    it { should exist }
    its('recorder_name') { should eq aws_configuration_recorder_name }
    its('role_arn') { should eq aws_config_recorder_role_arn }
    its('resource_types') { should eq [] }
    it { should be_recording }
    it { should be_recording_all_resource_types }
    it { should_not be_recording_all_global_types }
  end

  describe aws_config_recorder, :skip do
    its('last_status') { should eq 'FAILURE'}
  end

  describe aws_config_recorder(recorder_name: aws_configuration_recorder_name) do
    it { should exist }
    its('recorder_name') { should eq aws_configuration_recorder_name }
    its('role_arn') { should eq aws_config_recorder_role_arn }
    its('resource_types') { should eq [] }
    it { should be_recording }
    it { should be_recording_all_resource_types }
    it { should_not be_recording_all_global_types }
  end

  describe aws_config_recorder(recorder_name: aws_configuration_recorder_name), :skip do
    its('last_status') { should eq 'FAILURE'}
  end

  describe aws_config_recorder(recorder_name: 'notthere') do
    it { should_not exist }
  end
end
