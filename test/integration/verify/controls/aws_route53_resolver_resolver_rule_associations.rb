resolver_rule_association_id = input(:resolver_rule_association_id, value: '', description: '')
resolver_rule_id = input(:resolver_rule_id, value: '', description: '')
re_vpc_id = input(:re_vpc_id, value: '', description: '')

control 'aws-route53-resolver-resolver-rule-associations-1.0' do
  impact 1.0
  title 'List all the endpoint of the route53 resolver rule associations.'
  
  describe aws_route53resolver_resolver_rule_associations do
    it { should exist }
  end

  describe aws_route53resolver_resolver_rule_associations do
    its('ids') { should include resolver_rule_association_id }
    its('resolver_rule_ids') { should include resolver_rule_id }
    its('vpc_ids') { should include re_vpc_id }
    its('statuses') { should include "COMPLETE" }
    its('status_messages') { should_not be_empty }
  end
end
