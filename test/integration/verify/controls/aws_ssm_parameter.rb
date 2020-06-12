title 'Test a single AWS SSM Parameter'

aws_ssm_parameter_name  = attribute(:aws_ssm_parameter_name, default: '', description: 'The AWS SSM Parameter Name')
aws_ssm_parameter_type  = attribute(:aws_ssm_parameter_type, default: '', description: 'The AWS SSM Parameter Type')
aws_ssm_parameter_value = attribute(:aws_ssm_parameter_value, default: '', description: 'The AWS SSM Parameter Value')
aws_ssm_parameter_arn   = attribute(:aws_ssm_parameter_arn, default: '', description: 'The AWS SSM Parameter ARN.')

control 'aws-ssm-parameter-1.0' do

  impact 1.0
  title 'Ensure AWS SSM Parameter has current properties'

  describe aws_ssm_parameter(name: aws_ssm_parameter_name) do
    it { should exist }
  end

  describe aws_ssm_parameter(name: aws_ssm_parameter_name, with_decryption: 'true') do
    its('name')        { should eq aws_ssm_parameter_name }
    its('type')        { should eq aws_ssm_parameter_type }
    its('value')       { should eq aws_ssm_parameter_value }
    its('arn')         { should eq aws_ssm_parameter_arn }
  end

  describe aws_ssm_parameter(name: '000000') do
    it { should_not exist }
  end
end
