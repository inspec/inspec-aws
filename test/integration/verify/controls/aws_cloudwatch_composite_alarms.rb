control 'aws-cloudwatch-composite-alarms-1.0' do
  title 'List Composite Alarms.'

  describe aws_cloudwatch_composite_alarms do
    it { should exist }
  end

  describe aws_cloudwatch_composite_alarms do
    its('actions_enabled') { should include true }
    its('alarm_actions') { should_not be_empty }
    its('alarm_arns') { should_not be_empty }
    its('alarm_configuration_updated_timestamp') { should_not be_empty }
    its('alarm_descriptions') { should_not be_empty }
    its('alarm_names') { should include 'test1' }
    its('insufficient_data_actions') { should_not be_empty }
    its('ok_actions') { should_not be_empty }
    its('state_reasons') { should_not be_empty }
    its('state_updated_timestamp') { should_not be_empty }
    its('state_values') { should include 'OK' }
  end
end
