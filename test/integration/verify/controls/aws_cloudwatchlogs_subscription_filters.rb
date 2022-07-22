skip_control 'aws-cloudwatchlogs-subscription-filters-1.0' do
  impact 1.0
  title 'Describes the AWS cloudwatch filters.'
  
  describe aws_cloudwatchlogs_subscription_filters(log_group_name: 'LOG_GROUP_NAME') do
    it { should exist }
    its('filter_names') { should include 'FILTER_NAME' }
    its('log_group_names') { should include 'LOG_GROUP_NAME' }
    its('destination_arns') { should include 'DESTINATION_ARN' }
    its('role_arns') { should include nil }
  end
end