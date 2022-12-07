skip_control 'aws-lambda-event-invoke-config-1.0' do
  impact 1.0
  title 'Retrieves the configuration for asynchronous invocation for a function, version, or alias.'

  describe aws_lambda_layer_version_permission(layer_name: 'LayerName', version_number: 1) do
    it { should exist }
  end

  describe aws_lambda_layer_version_permission(layer_name: 'lambda_layer_name', version_number: 1) do
    its('policy') { should eq 'Policy' }
    its('revision_id') { should eq 'RevisionId' }
  end

  describe aws_lambda_layer_version_permission(layer_name: 'dummy', version_number: 1) do
    it { should_not exist }
  end
end
