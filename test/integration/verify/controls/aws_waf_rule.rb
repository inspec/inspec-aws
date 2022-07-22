aws_waf_rule_name = input(:aws_waf_rule_name, value: '', description: '')
aws_waf_rule_id = input(:aws_waf_rule_id, value: '', description: '')

control 'aws_waf_rule-1.0' do
  impact 1.0
  title 'Test the properties of a WAF Rule.'

  describe aws_waf_rule(rule_id: aws_waf_rule_id) do
    it { should exist }
    its('name') { should eq aws_waf_rule_name }
    its('rule_id') { should eq aws_waf_rule_id }
  end
end
