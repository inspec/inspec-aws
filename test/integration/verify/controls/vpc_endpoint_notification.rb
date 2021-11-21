aws_notification_id        = attribute(:aws_vpc_endpoint_notification_id, value: '', description: 'The AWS Subnet Group Name')
aws_notification_arn        = attribute(:aws_vpc_notifications_arn, value: '', description: 'The AWS Subnet Group Name')

title "Test single AWS VPC Notification"

describe aws_vpc_endpoint_connection_notification(connection_notification_id: aws_notification_id) do
  it { should exist }
  its('connection_notification_arn') { should eq aws_notification_arn }
  its('connection_notification_id') { should eq  aws_notification_id }
  its('connection_notification_state') { should eq  'Enabled' }
  its('connection_notification_type') { should eq 'Topic' }
  its('vpc_endpoint_id') { should eq nil }
end
