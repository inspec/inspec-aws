aws_api_gateway_usage_plan_id = input(:aws_api_gateway_usage_plan_id, value: '', description: '')
aws_api_gateway_usage_plan_name = input(:aws_api_gateway_usage_plan_name, value: '', description: '')
aws_api_gateway_usage_plan_description = input(:aws_api_gateway_usage_plan_description, value: '', description: '')
aws_api_gateway_usage_plan_product_code = input(:aws_api_gateway_usage_plan_product_code, value: '', description: '')

control 'aws-api-gateway-usage-plans-1.0' do
  impact 1.0
  title 'Test the properties of the api gateway usage plans.'

  describe aws_api_gateway_usage_plans do
    it { should exist }
  end

  describe aws_api_gateway_usage_plans do
    its ('ids') { should include aws_api_gateway_usage_plan_id }
    its ('names') { should include aws_api_gateway_usage_plan_name }
    its ('descriptions') { should include aws_api_gateway_usage_plan_description }
    its ('api_stages') { should_not be_empty }
    its ('throttles') { should_not be_empty }
    its ('product_codes') { should include aws_api_gateway_usage_plan_product_code }
    its ('tags') { should be_empty }
  end
end