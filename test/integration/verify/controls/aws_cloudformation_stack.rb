title 'Test single AWS CloudFormation Stack'

aws_cloudformation_stack_name = input(:aws_cloudformation_stack_name, value: '', description: 'The AWS CloudFormation stack name.')

control 'aws-cloudformation-stack-1.0' do
  title 'Ensure AWS CloudFormation Stack has the correct properties.'

  describe aws_cloudformation_stack(stack_name: aws_cloudformation_stack_name) do
    it                   { should exist }
    its ('stack_name')   { should eq aws_cloudformation_stack_name }
    its ('stack_status') { should eq 'CREATE_COMPLETE' }
  end
end
