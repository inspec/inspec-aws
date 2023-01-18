aws_api_gateway_account_cloudwatch_role_arn = input(:aws_api_gateway_account_cloudwatch_role_arn, value: '', description: '')

control 'aws-apigateway-account' do

  title 'Ensure API Gateway Account resource has the correct properties.'

  describe aws_apigateway_account do
    it { should exist }
  end

  describe aws_apigateway_account do
    its ('cloudwatch_role_arn') { should eq aws_api_gateway_account_cloudwatch_role_arn }
    its ('throttle_settings.burst_limit') { should eq 5000 }
    its ('features') { should include 'UsagePlans' }
    its ('api_key_version') { should eq '4' }
  end
end
