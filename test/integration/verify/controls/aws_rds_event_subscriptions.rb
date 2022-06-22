subscription_name = input(:subscription_name, value: '', description: '')

control 'aws_rds_event_subscriptions-1.0' do
  impact 1.0
  title 'Test the properties of Event Subscriptions.'
  
  describe aws_rds_event_subscriptions do
    it { should exist }
    its('customer_aws_ids') { should_not include '11384673629' }
    its('cust_subscription_ids') { should include subscription_name }
    its('enabled') { should include true }
    its('event_subscription_arns') { should_not include 'arn:aws:rds:us-east-2:11384673629:es:test-event-sub' }
  end
end
