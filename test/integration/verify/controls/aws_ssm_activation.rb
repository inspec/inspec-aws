title 'Test a single AWS SSM Activation'

control 'aws-ssm-activation-1.0' do
  impact 1.0
  title 'Ensure AWS SSM Activation has current properties'

  describe aws_ssm_activation(activation_id: 'dummy') do
    it { should_not exist }
  end
end
