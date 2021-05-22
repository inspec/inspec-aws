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
