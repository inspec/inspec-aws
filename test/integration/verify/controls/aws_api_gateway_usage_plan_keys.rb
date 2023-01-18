aws_api_gateway_usage_plan_id = attribute(:aws_api_gateway_usage_plan_id, value: '', description: '')
aws_api_gateway_usage_plan_key_id = attribute(:aws_api_gateway_usage_plan_key_id, value: '', description: '')
aws_api_gateway_usage_plan_key_key_type = attribute(:aws_api_gateway_usage_plan_key_key_type, value: '', description: '')
aws_api_gateway_usage_plan_key_name = attribute(:aws_api_gateway_usage_plan_key_name, value: '', description: '')
aws_api_gateway_usage_plan_key_value = attribute(:aws_api_gateway_usage_plan_key_value, value: '', description: '')

control 'aws-api-gateway-usage-plan-keys-1.0' do
  title 'Test the properties of the api gateway usage plan keys.'

  describe aws_api_gateway_usage_plan_keys(usage_plan_id: aws_api_gateway_usage_plan_id) do
    it { should exist }
  end

  describe aws_api_gateway_usage_plan_keys(usage_plan_id: aws_api_gateway_usage_plan_id) do
    its ('ids') { should include aws_api_gateway_usage_plan_key_id }
    its ('types') { should include aws_api_gateway_usage_plan_key_key_type }
    its ('values') { should include aws_api_gateway_usage_plan_key_value }
    its ('names') { should include aws_api_gateway_usage_plan_key_name }
  end
end
