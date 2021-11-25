# frozen_string_literal: true
event_subscription = attribute(:event_subscription, value: '', description: 'The AWS Auto Scaling Group name.')

control 'aws_rds_event_subscriptions-1.0' do
  impact 1.0
  title 'Test the properties of Event Subscription.'
  describe aws_rds_event_subscriptions do
    it { should exist }
    its('customer_aws_ids') { should include '11384673629' }
    its('cust_subscription_ids') { should include event_subscription }
    its('enabled') { should include true }
    its('event_subscription_arns') { should include 'arn:aws:rds:us-east-2:11384673629:es:test-event-sub' }
  end
end
