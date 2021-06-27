control 'aws-route53-resolver-resolver-endpoints-1.0' do
    impact 1.0
    title 'Describes the endpoints of the route53 resolver.'
  
    describe aws_route53resolver_resolver_endpoints do
        it { should exist }
    end

    describe aws_route53resolver_resolver_endpoints do
        its('ids') { should include "rslvr-in-69e093ed659c48fcb" }
        its('creator_request_ids') { should include "AWSConsole.17.1621684382681" }
        its('arns') { should include "arn:aws:route53resolver:us-east-2:112758395563:resolver-endpoint/rslvr-in-69e093ed659c48fcb"}
        its('names') { should include "test1" }
        its('security_group_ids') { should include ["sg-017797fbc10aa1e9e"] }
        its('directions') { should include "INBOUND" }
        its('ip_address_counts') { should include 2 }
        its('host_vpc_ids') { should include "vpc-08b86815ee2c22d53" }
        its('statuses') { should include "OPERATIONAL" }
        its('status_messages') { should include "This Resolver Endpoint is operational." }
        its('creation_times') { should include "2021-05-22T11:53:03.357976Z" }
        its('modification_times') { should include "2021-05-22T12:00:29.366Z" }
    end
end