aws_api_gateway_base_path_mapping_domain_name = input(:aws_api_gateway_base_path_mapping_domain_name, value: '', description: '')
aws_apigateway_base_path_mapping_base_path = input(:aws_apigateway_base_path_mapping_base_path, value: '(none)', description: '')
aws_api_gateway_rest_api_id1 = input(:aws_api_gateway_rest_api_id1, value: '', description: '')
aws_api_gateway_stage_name = input(:aws_api_gateway_stage_name, value: '', description: '')

control 'aws_apigateway_base_path_mappings-1.0' do
  impact 1.0
  title 'Describes the base path mapping for the specified API Gateway.'

  describe aws_apigateway_base_path_mappings(domain_name: aws_api_gateway_base_path_mapping_domain_name) do
    it { should exist }
  end

  describe aws_apigateway_base_path_mappings(domain_name: aws_api_gateway_base_path_mapping_domain_name) do
    it { should exist }
    its('base_paths') { should include aws_apigateway_base_path_mapping_base_path }
    its('rest_api_ids') { should include aws_api_gateway_rest_api_id1 }
    its('stages') { should include aws_api_gateway_stage_name }
  end
end