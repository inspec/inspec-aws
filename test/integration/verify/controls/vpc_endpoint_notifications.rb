aws_notification_id        = attribute(:aws_vpc_endpoint_notification_id, value: '', description: 'The AWS Subnet Group Name')
aws_notification_arn       = attribute(:aws_vpc_notifications_arn, value: '', description: 'The AWS Subnet Group Name')

title "Test multiple AWS VPC Notifications"

control "aws-vpc-endpoint-connection-notifications-1.0" do

  impact 1.0
  title "Check AWS vpc-endpoint-connection-notifications has the correct properties."

  describe aws_vpc_endpoint_connection_notifications do
    it { should exist }
    its('count') { should >= 1 }
    its('connection_notification_arns') { should include aws_notification_arn }
    its('connection_notification_ids') { should include aws_notification_id }
    its('connection_notification_state') { should include 'Enabled' }
    its('connection_notification_types') { should include 'Topic' }
    its('vpc_endpoint_ids') { should eq nil }
  end
end
