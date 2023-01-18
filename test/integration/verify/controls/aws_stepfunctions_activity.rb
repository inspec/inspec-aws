aws_sfn_activity_id = input(:aws_sfn_activity_id, value: '', description: '')
aws_sfn_activity_name = input(:aws_sfn_activity_name, value: '', description: '')

control 'aws-stepfunctions-activity-1.0' do
  title 'Test the properties of the stepfunctions activity.'

  describe aws_stepfunctions_activity(activity_arn: aws_sfn_activity_id) do
    it { should exist }
  end

  describe aws_stepfunctions_activity(activity_arn: aws_sfn_activity_id) do
    its('activity_arn') { should eq aws_sfn_activity_id }
    its('name') { should eq aws_sfn_activity_name }
  end
end
