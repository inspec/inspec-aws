title 'Test single AWS CloudFormation Stack set'

control 'aws-cloudformation-stack-1.0' do

  impact 1.0
  title 'Ensure AWS CloudFormation Stack has the correct properties.'
  describe aws_cloud_formation_stack_sets do
    it { should exist }
    its('stack_set_names') { should include 'test-stack' }
  end
end
