aws_api_gateway_deployement_id = input(:aws_api_gateway_deployement_id, value: '', description: '')
aws_api_gateway_rest_api_id_test = input(:aws_api_gateway_rest_api_id_test, value: '', description: '')

control 'aws-api-gateway-deployments-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway deployments.'

  describe aws_api_gateway_deployments(rest_api_id: aws_api_gateway_rest_api_id_test) do
    it { should exist }
  end

  describe aws_api_gateway_deployments(rest_api_id: aws_api_gateway_rest_api_id_test) do
    its('ids') { should include aws_api_gateway_deployement_id }
    its('descriptions') { should include 'test' }
    its('api_summaries') { should_not be_empty }
  end

  describe aws_api_gateway_deployments(rest_api_id: 'dummy') do
    it { should_not exist }
  end
end



