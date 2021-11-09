skip_control 'aws-cloudformation-templates-1.0' do

  impact 1.0
  title 'Ensure AWS CloudFormation Template has the correct properties using the parameter stack name.'

  describe aws_cloudformation_templates(stack_name: 'STACK_NAME') do
    it { should exist }
  end

  describe aws_cloudformation_templates(stack_name: 'STACK_NAME') do
    its('parameters') { should_not be_empty }
    its('descriptions') { should include 'Managed stack. Use AWS OpsWorks for Chef Automate to change or delete.' }
    its('capabilities') { should_not be_empty }
    its('capabilities_reasons') { should_not be_empty }
    its('resource_types') { should include ["AWS::EC2::Instance", "AWS::EC2::EIPAssociation"] }
    its('versions') { should_not be_empty }
    its('metadata') { should_not be_empty }
    its('declared_transforms') { should_not be_empty }
    its('resource_identifier_summaries') { should_not be_empty }
  end
end

skip_control 'aws-cloudformation-templates-2.0' do

  impact 1.0
  title 'Ensure AWS CloudFormation Template has the correct properties using the parameter template url.'

  describe aws_cloudformation_templates(template_url: 'TEMPLATE_URL') do
    it { should exist }
  end

  describe aws_cloudformation_templates(template_url: 'TEMPLATE_URL') do
    its('parameters') { should_not be_empty }
    its('descriptions') { should include 'Managed stack. Use AWS OpsWorks for Chef Automate to change or delete.' }
    its('capabilities') { should_not be_empty }
    its('capabilities_reasons') { should_not be_empty }
    its('resource_types') { should include ["AWS::ECR::Repository"] }
    its('versions') { should_not be_empty }
    its('metadata') { should_not be_empty }
    its('declared_transforms') { should_not be_empty }
    its('resource_identifier_summaries') { should_not be_empty }
  end
end