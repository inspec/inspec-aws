aws_notification_id = input(:aws_vpc_endpoint_notification_id, value: '', description: '')
aws_notification_arn = input(:aws_vpc_notifications_arn, value: '', description: '')

title "Test single AWS VPC Notification"

control "aws-vpc-endpoint-connection-notification-1.0" do
  impact 1.0
  title "Check AWS vpc-endpoint-connection-notification has the correct properties."

  describe aws_vpc_endpoint_connection_notification(connection_notification_id: aws_notification_id) do
    it { should exist }
  end

  describe aws_vpc_endpoint_connection_notification(connection_notification_id: aws_notification_id) do
    its('connection_notification_arn') { should eq aws_notification_arn }
    its('connection_notification_id') { should eq  aws_notification_id }
    its('connection_notification_state') { should eq 'Enabled' }
    its('connection_notification_type') { should eq 'Topic' }
    its('vpc_endpoint_id') { should eq nil }
  end
end


