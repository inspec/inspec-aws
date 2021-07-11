describe aws_api_gateway_deployment(rest_api_id: 'zq945ecmb4', deployment_id: '5gxykm') do
  it { should exist }
end

describe aws_api_gateway_deployment(rest_api_id: 'zq945ecmb4', deployment_id: '5gxykm') do
  its('id') { should eq '5gxykm' }
  its('description') { should eq 'test' }
  its('api_summary') { should be_empty }
end

describe aws_api_gateway_deployment(rest_api_id: 'dummy', deployment_id: 'dummy') do
  it { should_not exist }
end
