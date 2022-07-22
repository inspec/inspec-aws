aws_waf_web_acl_id = input(aws_waf_web_acl_id, value: '', description: '')
aws_waf_web_acl_name = input(aws_waf_web_acl_name, value: '', description: '')

title 'Ensure the web acl have the correct properties.'

control 'aws-waf-web-acl-1.0' do
  impact 1.0
  title 'Test the properties of the WAF ACL.'

  describe aws_waf_web_acl(web_acl_id: aws_waf_web_acl_id) do
    it { should exist }
  end

  describe aws_waf_web_acl(web_acl_id: aws_waf_web_acl_id) do
    its('web_acl_id') { should eq aws_waf_web_acl_id }
    its('name') { should eq aws_waf_web_acl_name }

    its('rules_priorities') { should_not be_empty }
    its('rules_rule_ids') { should_not be_empty }
    its('rules_actions') { should_not be_empty }
    its('rules_action_types') { should include 'BLOCK' }
    its('rules_override_actions') { should_not be_empty }
    its('rules_override_action_types') { should_not be_empty }
    its('rules_types') { should_not be_empty }
    its('rules_excluded_rules') { should_not be_empty }
    its('rules_excluded_rules_rule_ids') { should_not be_empty }
  end
end
