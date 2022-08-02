aws_api_gateway_base_path_mapping_domain_name = input(:aws_api_gateway_base_path_mapping_domain_name, value: '', description: '')
aws_apigateway_base_path_mapping_base_path = input(:aws_apigateway_base_path_mapping_base_path, value: '(none)', description: '')
aws_api_gateway_rest_api_id1 = input(:aws_api_gateway_rest_api_id1, value: '', description: '')
aws_api_gateway_stage_name = input(:aws_api_gateway_stage_name, value: '', description: '')

control 'aws_apigateway_base_path_mapping-1.0' do
  impact 1.0
  title 'Describes the base path mapping for the specified API Gateway.'

  describe aws_apigateway_base_path_mapping(domain_name: aws_api_gateway_base_path_mapping_domain_name, base_path: aws_apigateway_base_path_mapping_base_path) do
    it { should exist }
  end

  describe aws_apigateway_base_path_mapping(domain_name: aws_api_gateway_base_path_mapping_domain_name, base_path: aws_apigateway_base_path_mapping_base_path) do
    it { should exist }
    its('base_path') { should eq aws_apigateway_base_path_mapping_base_path }
    its('rest_api_id') { should eq aws_api_gateway_rest_api_id1 }
    its('stage') { should eq aws_api_gateway_stage_name }
  end
end