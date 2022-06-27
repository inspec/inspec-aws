aws_api_gateway_client_certificate_id = input(:aws_api_gateway_client_certificate_id, value: '', description: '')
aws_api_gateway_client_certificate_created_date = input(:aws_api_gateway_client_certificate_created_date, value: '', description: '')
aws_api_gateway_client_certificate_expiration_date = input(:aws_api_gateway_client_certificate_expiration_date, value: '', description: '')
aws_api_gateway_client_certificate_pem_encoded_certificate = input(:aws_api_gateway_client_certificate_pem_encoded_certificate, value: '', description: '')

control 'aws-apigateway-client-certificates' do
  impact 1.0
  title 'Ensure API Gateway Client Certificate resource has the correct properties.'

  describe aws_apigateway_client_certificates do
    its('client_certificate_ids') { should include aws_api_gateway_client_certificate_id }
    its('descriptions') { should include 'My client certificate.' }
    its('pem_encoded_certificates') { should include aws_api_gateway_client_certificate_pem_encoded_certificate }
    its('created_dates') { should include Time.parse(aws_api_gateway_client_certificate_created_date) }
    its('expiration_dates') { should include Time.parse(aws_api_gateway_client_certificate_expiration_date) }
    its('tags') { should_not be_empty }
  end
end