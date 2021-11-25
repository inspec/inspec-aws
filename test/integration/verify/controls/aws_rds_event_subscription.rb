# frozen_string_literal: true
event_subscription = attribute(:event_subscription, value: '', description: '')

control 'aws_rds_event_subscription-1.0' do
  impact 1.0
  title 'Test the properties of Event Subscription.'
  describe aws_rds_event_subscription(subscription_name: event_subscription) do
    it { should exist }
    its('customer_aws_id') { should eq '11384673629' }
    its('cust_subscription_id') { should eq event_subscription }
    its('enabled') { should eq true }
    its('event_subscription_arn') { should eq 'arn:aws:rds:us-east-2:11384673629:es:test-event-sub' }
  end
end