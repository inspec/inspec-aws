title 'Test Multiple Metric Stream'

skip_control 'aws-cloudwatch-metric-stream-1.0' do
  title 'Ensure AWS cloudwatch metric streams has the correct properties.'

  describe aws_cloudwatch_insight_rules do
    it { should exist }
    its('states') { should include 'enabled' }
    its('names') { should include 'test-rule' }
  end
end
