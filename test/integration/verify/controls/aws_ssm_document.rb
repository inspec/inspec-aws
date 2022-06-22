title 'Test a single AWS SSM Document'

aws_ssm_document_name = input(:aws_ssm_document_name, value: '', description: 'The AWS SSM Document Name')
aws_ssm_document_document_type = input(:aws_ssm_document_document_type, value: '', description: 'The AWS SSM Document Command')

control 'aws-ssm-document-1.0' do
  impact 1.0
  title 'Ensure AWS SSM Document has current properties'

  describe aws_ssm_document(name: aws_ssm_document_name) do
    it { should exist }
  end

  describe aws_ssm_document(name: aws_ssm_document_name) do
    its('name')          { should eq aws_ssm_document_name }
    its('document_type') { should eq aws_ssm_document_document_type }
  end

  describe aws_ssm_document(name: 'dummy') do
    it { should_not exist }
  end
end
