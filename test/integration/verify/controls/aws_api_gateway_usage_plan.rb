aws_api_gateway_usage_plan_id = input(:aws_api_gateway_usage_plan_id, value: '', description: '')
aws_api_gateway_usage_plan_name = input(:aws_api_gateway_usage_plan_name, value: '', description: '')
aws_api_gateway_usage_plan_description = input(:aws_api_gateway_usage_plan_description, value: '', description: '')
aws_api_gateway_usage_plan_product_code = input(:aws_api_gateway_usage_plan_product_code, value: '', description: '')

control 'aws-api-gateway-usage-plan-1.0' do
  title 'Test the properties of the api gateway usage plan.'

  describe aws_api_gateway_usage_plan(usage_plan_id: aws_api_gateway_usage_plan_id) do
    it { should exist }
  end

  describe aws_api_gateway_usage_plan(usage_plan_id: aws_api_gateway_usage_plan_id) do
    its ('id') { should eq aws_api_gateway_usage_plan_id }
    its ('name') { should eq aws_api_gateway_usage_plan_name }
    its ('description') { should eq aws_api_gateway_usage_plan_description }

    its ('api_stages') { should_not be_empty }
    its ('api_stages_api_ids') { should_not be_empty }
    its ('api_stages_stages') { should include 'development' }
    its ('api_stages_throttles') { should_not be_empty }

    its ('throttle.burst_limit') { should eq 5 }
    # its ('throttle.rate_limit') { should eq 10.0 }

    its ('quota.limit') { should eq 20 }
    its ('quota.offset') { should eq 2 }
    its ('quota.period') { should eq 'WEEK' }

    its ('product_code') { should eq aws_api_gateway_usage_plan_product_code }
    its ('tags') { should be_empty }
  end
end
