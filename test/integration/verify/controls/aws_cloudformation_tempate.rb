skip_control 'aws-cloudformation-template-1.0' do
  impact 1.0
  title 'Ensure AWS CloudFormation Template has the correct properties using the parameter stack name.'

  describe aws_cloudformation_template(stack_name: 'STACK_NAME') do
    it { should exist }
  end

  describe aws_cloudformation_template(stack_name: 'STACK_NAME') do
    its('parameter_keys') { should include 'HttpsCACertificates' }
    its('default_values') { should_not be_empty }
    its('parameter_types') { should include 'String' }
    its('no_echos') { should include false }
    its('descriptions') { should include 'Intermediate CA certificates chain. This can be one or more certificate PEMs concatenated together.' }
  end

  describe aws_cloudformation_template(stack_name: 'STACK_NAME') do
    its('description') { should include 'Managed stack. Use AWS OpsWorks for Chef Automate to change or delete.' }
    its('capabilities') { should be_empty }
    its('capabilities_reason') { should be_empty }
    its('resource_types') { should include 'AWS::EC2::Instance' }
    its('version') { should include '2010-09-09' }
    its('metadata') { should be_empty }
    its('declared_transforms') { should be_empty }
  end

  describe aws_cloudformation_template(stack_name: 'STACK_NAME') do
    its('resource_types') { should include 'AWS::EC2::Instance' }
    its('logical_resource_ids') { should include ['EC2Instance'] }
    its('resource_identifiers') { should include ['InstanceId'] }
  end
end

skip_control 'aws-cloudformation-template-2.0' do
  impact 1.0
  title 'Ensure AWS CloudFormation Template has the correct properties using the parameter template url.'

  describe aws_cloudformation_template(template_url: 'TEMPLATE_URL') do
    it { should exist }
  end

  describe aws_cloudformation_template(template_url: 'TEMPLATE_URL') do
    its('parameter_keys') { should include 'ECRrepo' }
    its('default_values') { should include 'aws-cloudformation-stack-ecr-name-abcd1234' }
    its('parameter_types') { should include 'String' }
    its('no_echos') { should include false }
    its('descriptions') { should include 'ECR repo created by cloud formation.' }
  end

  describe aws_cloudformation_template(template_url: 'TEMPLATE_URL') do
    its('description') { should be_empty }
    its('capabilities') { should be_empty }
    its('capabilities_reason') { should be_empty }
    its('resource_types') { should include 'AWS::ECR::Repository' }
    its('version') { should include '2010-09-09' }
    its('metadata') { should be_empty }
    its('declared_transforms') { should be_empty }
  end

  describe aws_cloudformation_template(template_url: 'TEMPLATE_URL') do
    its('resource_types') { should include 'AWS::ECR::Repository' }
    its('logical_resource_ids') { should include ['myEcrRepo'] }
    its('resource_identifiers') { should include ['RepositoryName'] }
  end
end