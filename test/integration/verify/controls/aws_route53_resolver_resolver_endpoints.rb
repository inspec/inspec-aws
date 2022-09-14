resolver_endpoint_id = input(:aws_resolver_endpoint_id, value: '', description: '')
aws_resolver_endpoint_vpc_id = input(:aws_resolver_endpoint_vpc_id, value: '', description: '')
aws_resolver_endpoint_name = input(:aws_resolver_endpoint_name, value: '', description: '')
aws_resolver_endpoint_arn = input(:aws_resolver_endpoint_arn, value: '', description: '')

control 'aws-route53-resolver-resolver-endpoints-1.0' do
  impact 1.0
  title 'Describes the endpoints of the route53 resolver.'
  
  describe aws_route53resolver_resolver_endpoints do
    it { should exist }
  end
  
  describe aws_route53resolver_resolver_endpoints do
    its('ids') { should include resolver_endpoint_id }
    its('arns') { should include aws_resolver_endpoint_arn}
    its('names') { should include aws_resolver_endpoint_name }
    its('security_group_ids') { should include ["sg-017797fbc10aa1e9e"] }
    its('directions') { should include "INBOUND" }
    its('ip_address_counts') { should include 2 }
    its('host_vpc_ids') { should include aws_resolver_endpoint_vpc_id }
  end
end
