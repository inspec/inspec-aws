control 'aws-api-gateway-deployments-1.0' do

    impact 1.0
    title 'Ensure AWS APIGateway Deployments has current properties'

    describe aws_api_gateway_deployments(rest_api_id: 'zq945ecmb4') do
        it { should exist }
    end

    describe aws_api_gateway_deployments(rest_api_id: 'zq945ecmb4') do
        its('ids') { should include '11vmxl' }
        its('descriptions') { should include 'test' }
        its('api_summaries') { should_not be_empty }
    end

    describe aws_api_gateway_deployments(rest_api_id: 'dummy') do
        it { should_not exist }
    end
end