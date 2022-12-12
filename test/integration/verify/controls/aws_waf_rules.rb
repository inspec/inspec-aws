aws_waf_rule_name = input(:aws_waf_rule_name, value: '', description: '')
aws_waf_rule_id = input(:aws_waf_rule_id, value: '', description: '')

control 'aws_waf_rules-1.0' do
  title 'Test the properties of all the WAF Rules.'

  describe aws_waf_rules do
    it { should exist }
    its('names') { should include aws_waf_rule_name }
    its('rule_ids') { should include aws_waf_rule_id }
  end
end
