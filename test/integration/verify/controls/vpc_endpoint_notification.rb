aws_vpcen_id = attribute(:aws_vpc_endpoint_notification_id, default: '', description: 'The AWS VPC Endpoint Notification ID.')

title "Test multiple AWS VPC Notifications"
control "aws-vpc-endpoint-connection-notifications-1.0" do

  impact 1.0
  title "Check AWS vpc-endpoint-connection-notifications has the correct properties."

  describe aws_vpc_endpoint_connection_notification(connection_notification_id: aws_vpcen_id) do
    it { should exist }
    its('connection_notification_arn') { should eq 'arn:aws:sns:us-east-2:112758395563:aws-sns-topic-encryption-bloixlvrsnfyblzxnbgcbvhju' }
    its('connection_notification_id') { should eq  'vpce-nfn-03ad3532a5c71f8af' }
    its('connection_notification_state') { should eq  'Enabled' }
    its('connection_notification_type') { should eq 'Topic' }
    its('vpc_endpoint_id') { should eq nil }

  end
end
