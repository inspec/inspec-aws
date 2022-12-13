control 'aws-cloudwatch-composite-alarm-1.0' do
  title 'Get the information about a composite alarm.'

  describe aws_cloudwatch_composite_alarm(alarm_name: 'test1') do
    it { should exist }
  end

  describe aws_cloudwatch_composite_alarm(alarm_name: 'test1') do
    its('actions_enabled') { should eq true }
    its('alarm_actions') { should be_empty }
    its('alarm_arn') { should_not be_empty }
    its('alarm_configuration_updated_timestamp') { should_not be_empty }
    its('alarm_description') { should be_empty }
    its('alarm_name') { should eq 'test1' }
    its('insufficient_data_actions') { should be_empty }
    its('ok_actions') { should be_empty }
    its('state_reason') { should_not be_empty }
    its('state_updated_timestamp') { should_not be_empty }
    its('state_value') { should eq 'OK' }
  end
end
