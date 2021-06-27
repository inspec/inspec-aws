control 'aws-route53-resolver-resolver-rule-associations-1.0' do
    impact 1.0
    title 'List all the endpoint of the route53 resolver rule associations.'
  
    describe aws_route53resolver_resolver_rule_associations do
        it { should exist }
    end

    describe aws_route53resolver_resolver_rule_associations do
        its('ids') { should include "rslvr-autodefined-assoc-vpc-00727fc4213acee4a-internet-resolver" }
        its('resolver_rule_ids') { should include "rslvr-autodefined-rr-internet-resolver" }
        its('names') { should include "System Rule Association" }
        its('vpc_ids') { should include "vpc-00727fc4213acee4a" }
        its('statuses') { should include "COMPLETE" }
        its('status_messages') { should_not be_empty }
    end
end
