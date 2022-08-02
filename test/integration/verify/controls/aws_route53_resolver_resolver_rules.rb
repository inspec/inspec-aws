resolver_rule_id= input(:resolver_rule_id, value: '', description: '')
resolver_rule_arn = input(:resolver_rule_arn, value: '', description: '')
resolver_rule_type = input(:resolver_rule_type, value: '', description: '')

control 'aws-route53-resolver-resolver-resolver-rules-1.0' do
  impact 1.0
  title 'List all resolver rules of the route53 resolver.'
  
  describe aws_route53resolver_resolver_rules do
    it { should exist }
  end

  describe aws_route53resolver_resolver_rules do
    its('ids') { should include resolver_rule_id }
    its('creator_request_ids') { should include "" }
    its('arns') { should include resolver_rule_arn }
    its('domain_names') { should include "subdomain.example.com." }
    its('statuses') { should include "COMPLETE" }
    its('status_messages') { should_not be_empty }
    its('rule_types') { should include resolver_rule_type }
    its('target_ips') { should_not be_empty }
    its('resolver_endpoint_ids') { should_not be_empty }
    its('modification_times') { should_not be_empty }
  end
end
