control 'aws-route53-resolver-resolver-resolver-rules-1.0' do
    impact 1.0
    title 'List all resolver rules of the route53 resolver.'
  
    describe aws_route53resolver_resolver_rules do
        it { should exist }
    end

    describe aws_route53resolver_resolver_rules do
        its('ids') { should include "rslvr-autodefined-rr-internet-resolver" }
        its('creator_request_ids') { should include "" }
        its('arns') { should include "arn:aws:route53resolver:us-east-2::autodefined-rule/rslvr-autodefined-rr-internet-resolver" }
        its('domain_names') { should include "." }
        its('statuses') { should include "COMPLETE" }
        its('status_messages') { should_not be_empty }
        its('rule_types') { should include "RECURSIVE" }
        its('names') { should include "Internet Resolver" }
        its('target_ips') { should_not be_empty }
        its('resolver_endpoint_ids') { should_not be_empty }
        its('owner_ids') { should include "Route 53 Resolver" }
        its('share_statuses') { should include "NOT_SHARED" }
        its('modification_times') { should_not be_empty }
    end
end