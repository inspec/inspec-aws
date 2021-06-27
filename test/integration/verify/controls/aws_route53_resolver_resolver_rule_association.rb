control 'aws-route53-resolver-resolver-rule-association-1.0' do
    impact 1.0
    title 'Describes the rule association of the route53 resolver.'
  
    describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'rslvr-autodefined-assoc-vpc-00727fc4213acee4a-internet-resolver') do
        it { should exist }
    end

    describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'rslvr-autodefined-assoc-vpc-00727fc4213acee4a-internet-resolver') do
        its('id') { should eq "rslvr-autodefined-assoc-vpc-00727fc4213acee4a-internet-resolver" }
        its('resolver_rule_id') { should eq "rslvr-autodefined-rr-internet-resolver" }
        its('name') { should eq "System Rule Association" }
        its('vpc_id') { should eq "vpc-00727fc4213acee4a" }
        its('status') { should eq "COMPLETE" }
        its('status_message') { should be_empty }
    end
  
    describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'dummy') do
        it { should_not exist }
    end
end