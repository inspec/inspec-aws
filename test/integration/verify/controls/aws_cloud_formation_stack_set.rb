title 'Test single AWS CloudFormation Stack set'

aws_cloudformation_stack_name = input(:aws_cloudformation_stack_name, value: '', description: 'The AWS CloudFormation stack name.')

control 'aws-cloudformation-stack-1.0' do
  impact 1.0
  title 'Ensure AWS CloudFormation Stack has the correct properties.'

  describe aws_cloud_formation_stack_sets do
    it { should exist }
    its('stack_set_name') { should eq aws_cloudformation_stack_name }
  end
end
