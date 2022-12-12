aws_cloudwatch_event_rule_arn = input(:aws_cloudwatch_event_rule_arn, value: '', description: '')

control 'aws-event-rules-1.0' do
  title 'Ensure AWS Event Rules has the correct properties.'

  describe aws_eventbridge_rules do
    it { should exist }
  end

  describe aws_eventbridge_rules do
    its('names') { should include 'test_rule' }
    its('arns') { should include aws_cloudwatch_event_rule_arn }
    its('event_patterns') { should_not be_empty }
    its('states') { should include 'ENABLED' }
    its('descriptions') { should include "Description of the rule." }
    its('schedule_expressions') { should be_empty }
    its('role_arns') { should be_empty }
    its('managed_bys') { should be_empty }
    its('event_bus_names') { should include 'default' }
  end
end
