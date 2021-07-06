describe aws_api_gateway_restapi(rest_api_id: "52dopn0m97") do
  it { should exist }
end

describe aws_api_gateway_restapi(rest_api_id: "52dopn0m97") do
  its('id') { should eq '52dopn0m97' }
  its('name') { should eq 'deployment1' }
  its('description') { should be_empty }
  its('version') { should be_empty }
  its('warnings') { should be_empty }
  its('binary_media_types') { should be_empty }
  its('minimum_compression_size') { should be_empty }
  its('api_key_source') { should_not be_empty }
  its('endpoint_configuration.types') { should eq ["PRIVATE"] }
  its('endpoint_configuration.vpc_endpoint_ids') { should be_empty }
  its('policy') { should_not be_empty }
  its('tags') { should be_empty }
  its('disable_execute_api_endpoint') { should eq false }
end