aws_cloudwatch_event_rule_arn = input(:aws_cloudwatch_event_rule_arn, value: '', description: '')

control 'aws-event-rule-1.0' do
  impact 1.0
  title 'Ensure AWS Event Rule has the correct properties.'

  describe aws_eventbridge_rule(name: 'test_rule') do
    it { should exist }
  end

  describe aws_eventbridge_rule(name: 'test_rule') do
    its('name') { should eq 'test_rule' }
    its('arn') { should eq aws_cloudwatch_event_rule_arn }
    its('event_pattern') { should_not be_empty }
    its('state') { should eq 'ENABLED' }
    its('description') { should eq "Description of the rule." }
    its('schedule_expression') { should be_empty }
    its('role_arn') { should be_empty }
    its('managed_by') { should be_empty }
    its('event_bus_name') { should eq 'default' }
  end
end
