title "Test multiple AWS VPC Notifications"
control "aws-vpc-endpoint-connection-notifications-1.0" do

  impact 1.0
  title "Check AWS vpc-endpoint-connection-notifications has the correct properties."

  describe aws_vpc_endpoint_connection_notifications do
    it { should exist }
    its('count') { should eq 1 }
    its('connection_notification_arns') { should include 'arn:aws:sns:us-east-2:112758395563:aws-sns-topic-encryption-bloixlvrsnfyblzxnbgcbvhju' }
    its('connection_notification_ids') { should include 'vpce-nfn-03ad3532a5c71f8af' }
    its('connection_notification_state') { should include 'Enabled' }
    its('connection_notification_types') { should include 'Topic' }
    its('connection_events') { should be_in [%w{Delete Reject Connect Accept}] }
    its('vpc_endpoint_ids') { should eq nil }
  end
end
