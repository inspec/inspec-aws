control 'aws-route53-resolver-resolver-rule-1.0' do
    impact 1.0
    title 'Describes the resolver rule of the route53.'
  
    describe aws_route53resolver_resolver_rule(resolver_rule_id: 'rslvr-autodefined-rr-internet-resolver') do
        it { should exist }
    end

    describe aws_route53resolver_resolver_rule(resolver_rule_id: 'rslvr-autodefined-rr-internet-resolver') do
        its('id') { should eq "rslvr-autodefined-rr-internet-resolver" }
        its('creator_request_id') { should eq "" }
        its('arn') { should eq "arn:aws:route53resolver:us-east-2::autodefined-rule/rslvr-autodefined-rr-internet-resolver" }
        its('domain_name') { should eq "." }
        its('status') { should eq "COMPLETE" }
        its('status_message') { should be_empty }
        its('rule_type') { should eq "RECURSIVE" }
        its('name') { should eq "Internet Resolver" }
        its('target_ips') { should be_empty }
        its('target_ips.first.ip') { should be_empty }
        its('target_ips.first.port') { should be_empty }
        its('resolver_endpoint_id') { should be_empty }
        its('owner_id') { should eq "Route 53 Resolver" }
        its('share_status') { should eq "NOT_SHARED" }
        its('modification_time') { should be_empty }
    end
  
    describe aws_route53resolver_resolver_rule(resolver_rule_id: 'dumy') do
        it { should_not exist }
    end
end