describe aws_route53resolver_resolver_endpoint(resolver_endpoint_id: 'rslvr-in-69e093ed659c48fcb') do
    it { should exist }
end

describe aws_route53resolver_resolver_endpoint(resolver_endpoint_id: 'rslvr-in-69e093ed659c48fcb') do
    its('id') { should eq "rslvr-in-69e093ed659c48fcb" }
    its('creator_request_id') { should eq "AWSConsole.17.1621684382681" }
    its('arn') { should eq "arn:aws:route53resolver:us-east-2:112758395563:resolver-endpoint/rslvr-in-69e093ed659c48fcb" }
    its('name') { should eq "test1" }
    its('direction') { should eq "INBOUND" }
    its('ip_address_count') { should eq 2 }
    its('host_vpc_id') { should eq "vpc-08b86815ee2c22d53" }
    its('status') { should eq "OPERATIONAL" }
    its('status_message') { should eq "This Resolver Endpoint is operational." }
    its('creation_time') { should eq "2021-05-22T11:53:03.357976Z" }
    its('modification_time') { should eq "2021-05-22T12:00:29.366Z" }
end