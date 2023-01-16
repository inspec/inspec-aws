skip_control 'aws-cloudwatch-logs-destinations-1.0' do
  title 'Describes the AWS cloudwatch destinations.'

  describe aws_cloudwatchlogs_destinantions do
    it { should exist }
    its('destination_names') { should include 'DESTINATION_NAME' }
    its('target_arns') { should include 'TARGET_NAME' }
    its('role_arns') { should include 'ROLE_ARN' }
    its('access_policies') { should include nil }
    its('arns') { should include 'ARN' }
  end
end
