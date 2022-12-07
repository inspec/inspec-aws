title 'Test AWS CloudFormation Stacks in bulk'

aws_cloudformation_stack_name = input(:aws_cloudformation_stack_name, value: '', description: 'The AWS CloudFormation stack name.')

control 'aws-cloudformation-stacks-1.0' do
  impact 1.0
  title 'Ensure AWS CloudFormation Stacks has the correct properties.'

  aws_cloudformation_stacks.names.each do |stack|
    describe aws_cloudformation_stack(stack_name: stack) do
      it                   { should exist }
      its ('notification_arn')   { should_not be_empty}
      its ('stack_status') { should eq 'CREATE_COMPLETE' }
    end
  end
end