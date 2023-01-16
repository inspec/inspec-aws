aws_api_gateway_client_certificate_id = input(:aws_api_gateway_client_certificate_id, value: '', description: '')
aws_api_gateway_client_certificate_created_date = input(:aws_api_gateway_client_certificate_created_date, value: '', description: '')
aws_api_gateway_client_certificate_expiration_date = input(:aws_api_gateway_client_certificate_expiration_date, value: '', description: '')
aws_api_gateway_client_certificate_pem_encoded_certificate = input(:aws_api_gateway_client_certificate_pem_encoded_certificate, value: '', description: '')

control 'aws-apigateway-client-certificate' do
  title 'Ensure API Gateway Client Certificate resource has the correct properties.'

  describe aws_apigateway_client_certificate(client_certificate_id: aws_api_gateway_client_certificate_id) do
    it { should exist }
  end

  describe aws_apigateway_client_certificate(client_certificate_id: aws_api_gateway_client_certificate_id) do
    its('client_certificate_id') { should eq aws_api_gateway_client_certificate_id }
    its('description') { should eq 'My client certificate.' }
    its('pem_encoded_certificate') { should eq aws_api_gateway_client_certificate_pem_encoded_certificate }
    its('created_date') { should eq Time.parse(aws_api_gateway_client_certificate_created_date) }
    its('expiration_date') { should eq Time.parse(aws_api_gateway_client_certificate_expiration_date) }
    its('tags') { should be_empty }
  end
end
