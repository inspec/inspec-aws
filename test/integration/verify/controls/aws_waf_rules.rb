aws_waf_rule_name = attribute(:aws_waf_rule_name, value: '')
aws_waf_rule_id = attribute(:aws_waf_rule_id, value: '')

control 'aws_waf_rules-1.0' do
  impact 1.0
  title 'Test the properties of all the WAF Rules.'

  describe aws_waf_rules do
    it { should exist }
    its('names') { should include aws_waf_rule_name }
    its('rule_ids') { should include aws_waf_rule_id }
  end
end
