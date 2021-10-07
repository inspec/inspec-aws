control 'aws-api-gateway-client-certificate-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway client certificate.'

  describe aws_api_gateway_client_certificate(client_certificate_id: 'u4hmzc') do
    it { should exist }
  end

  describe aws_api_gateway_client_certificate(client_certificate_id: 'u4hmzc') do
    its('client_certificate_id') { should eq 'u4hmzc' }
    its('description') { should eq 'My client certificate.' }
    its('pem_encoded_certificate') { should_not be_empty }
    its('tags') { should be_empty }
  end
end