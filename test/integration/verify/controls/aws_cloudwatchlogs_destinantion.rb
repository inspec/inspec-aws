skip_control 'aws-cloudwatch-logs-destination-1.0' do
  impact 1.0
  title 'Describes the AWS cloudwatch destination.'

  describe aws_cloudwatchlogs_destinantion(destination_name_prefix: 'DESTINATION_NAME') do
    it { should exist }
    its('destination_name') { should eq 'DESTINATION_NAME' }
    its('target_arn') { should eq 'TARGET_NAME' }
    its('role_arn') { should eq 'ROLE_ARN' }
    its('access_policie') { should eq nil }
    its('arn') { should eq 'ARN' }
  end
end
