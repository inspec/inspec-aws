describe aws_api_gateway_restapi(rest_api_id: "rest_api_id") do
	it { should exist }
end

describe aws_api_gateway_restapi(rest_api_id: "rest_api_id") do
	its('id') { should eq 'id' }
	its('name') { should eq 'name' }
	its('description') { should eq 'description' }
	its('created_date') { should eq 'created_date' }
	its('version') { should eq 'version' }
	its('warnings') { should eq 'warnings' }
	its('binary_media_types') { should eq 'binary_media_types' }
	its('minimum_compression_size') { should eq 'minimum_compression_size' }
	its('api_key_source') { should eq 'HEADER' }
	its('endpoint_configuration.types') { should eq 'endpoint_configuration.types' }
	its('endpoint_configuration.vpc_endpoint_ids') { should eq 'endpoint_configuration.vpc_endpoint_ids' }
	its('policy') { should eq 'policy' }
	its('tags') { should eq 'tags' }
	its('disable_execute_api_endpoint') { should eq true }
end

describe aws_api_gateway_restapi(rest_api_id: "dummy") do
	its { should_not exist }
end