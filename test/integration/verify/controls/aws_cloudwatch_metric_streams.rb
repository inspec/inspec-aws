stream_arns = input(:dashboard_arn, value: '', description: '')
stream_names = input(:dashboard_name, value: '', description: '')

title 'Test Plural metric stream'

control 'aws-cloudwatch-metric-streams-1.0' do
  impact 1.0
  title 'Ensure AWS cloudwatch metric streams has the correct properties.'

  describe aws_cloudwatch_metric_streams do
    it { should exist }
    its('arns') { should include stream_arns }
    its('names') { should include stream_names }
  end
end