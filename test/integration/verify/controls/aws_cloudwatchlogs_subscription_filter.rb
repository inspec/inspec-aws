skip_control 'aws-cloudwatchlogs-subscription-filter-1.0' do
  title 'Describes the AWS cloudwatch filter.'
  
  describe aws_cloudwatchlogs_subscription_filter(log_group_name: 'LOG_GROUP_NAME', filter_name_prefix: 'FILTER_NAME') do
    it { should exist }
    its('filter_name') { should eq 'FILTER_NAME' }
    its('log_group_name') { should eq 'LOG_GROUP_NAME' }
    its('destination_arn') { should eq 'DESTINATION_ARN' }
    its('role_arn') { should eq nil }
  end
end
