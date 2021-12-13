aws_waf_sql_injection_match_set_name = attribute(:aws_waf_sql_injection_match_set_name, value: '')
aws_waf_sql_injection_match_set_id = attribute(:aws_waf_sql_injection_match_set_id, value: '')

control 'aws_waf_sql_injection_match_set-1.0' do
  impact 1.0
  title 'Test the properties of single WAF SQL Injection Match Set.'
  describe aws_waf_sql_injection_match_set(sql_injection_match_set_id: aws_waf_sql_injection_match_set_id) do
    it { should exist }
    its('name') { should eq aws_waf_sql_injection_match_set_name }
    its('sql_injection_match_set_id') { should eq aws_waf_sql_injection_match_set_id }
  end
end
