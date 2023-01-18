title 'Test AWS SSM Parameters in bulk'

aws_ssm_parameter_name = input(:aws_ssm_parameter_name, value: '', description: 'The AWS SSM Parameter Name')

control 'aws-ssm-parameters-1.0' do
  title 'Ensure AWS SSM Parameter has current properties'

  describe aws_ssm_parameters do
    it { should exist }
  end

  describe aws_ssm_parameters do
    its('names') { should include aws_ssm_parameter_name }
  end
end
