title 'Test AWS SSM Documents in bulk'

aws_ssm_document_name = input(:aws_ssm_document_name, value: '', description: 'The AWS SSM Document Name')
aws_ssm_document_document_type = input(:aws_ssm_document_document_type, value: '', description: 'The AWS SSM Document Command')

control 'aws-ssm-documents-1.0' do
  impact 1.0
  title 'Ensure AWS SSM Document has current properties'

  describe aws_ssm_documents do
    it { should exist }
  end

  describe aws_ssm_documents do
    its('names') { should include aws_ssm_document_name }
    its('document_types') { should include aws_ssm_document_document_type }
  end
end
