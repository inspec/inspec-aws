stream_arns = input(:dashboard_arn, value: '', description: '')
stream_names = input(:dashboard_name, value: '', description: '')

title 'Test Multiple Metric Stream'

control 'aws-cloudwatch-metric-stream-1.0' do
  impact 1.0
  title 'Ensure AWS cloudwatch metric streams has the correct properties.'

  describe aws_cloudwatch_metric_stream(metric_stream_name: stream_names) do
    it { should exist }
    its('arn'){ should eq stream_arns }
    its('name') { should eq stream_names }
  end
end

