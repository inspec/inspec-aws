aws_waf_sql_injection_match_set_id = attribute(aws_waf_sql_injection_match_set_id, value: '', description: '')
aws_waf_sql_injection_match_set_name = attribute(aws_waf_sql_injection_match_set_name, value: '', description: '')

title 'Ensure the sql injection match sets have the correct properties.'

control 'aws-waf-sql-injection-match-sets-1.0' do
  impact 1.0

  describe aws_waf_sql_injection_match_sets do
    it { should exist }
  end

  describe aws_waf_sql_injection_match_sets do
    its('sql_injection_match_set_ids') { should include aws_waf_sql_injection_match_set_id }
    its('names') { should include aws_waf_sql_injection_match_set_name }
  end
end