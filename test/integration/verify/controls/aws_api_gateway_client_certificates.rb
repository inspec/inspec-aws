control 'aws-api-gateway-client-certificates-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway client certificate.'

  describe aws_api_gateway_client_certificates do
    it { should exist }
  end

  describe aws_api_gateway_client_certificates do
    its('client_certificate_ids') { should include 'u4hmzc' }
    its('descriptions') { should include 'My client certificate.' }
    its('pem_encoded_certificates') { should_not be_empty }
    its('tags') { should_not be_empty }
  end
end