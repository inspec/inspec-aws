title 'Test a single AWS SSM Association'

control 'aws-ssm-association-1.0' do
  title 'Ensure AWS SSM Association has current properties'

  describe aws_ssm_association(association_id: 'dummy') do
    it { should_not exist }
  end
end
