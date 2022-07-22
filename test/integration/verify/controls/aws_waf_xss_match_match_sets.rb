aws_waf_xss_match_set_name = input(:aws_waf_xss_match_set_name, value: '', description: '')
aws_waf_xss_match_set_id = input(:aws_waf_xss_match_set_id, value: '', description: '')

control 'aws-waf-size-constraint-sets-1.0' do
  impact 1.0
  title 'Test the properties of all WAF xss match sets.'

  describe aws_waf_xss_match_sets do
    it { should exist }
    its('names') { should include aws_waf_xss_match_set_name }
    its('xss_match_set_ids') { should include aws_waf_xss_match_set_id }
  end
end
