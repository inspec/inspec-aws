title 'Ensure AWS credentials being used for the Inspec scan have the correct properties.'

control 'aws-sts-caller-identity-1.0' do
  title 'Make sure we are not on GovCloud'

  describe aws_sts_caller_identity do
    it          { should exist }
    it          { should_not be_govcloud }
    its ('arn') { should_not be_nil }
  end
end
