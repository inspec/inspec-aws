aws_waf_xss_match_set_name = attribute(:aws_waf_xss_match_set_name, value: '')
aws_waf_xss_match_set_id = attribute(:aws_waf_xss_match_set_id, value: '')

control 'aws-waf-size-constraint-sets-1.0' do

  impact 1.0
  title 'Test the properties of all WAF XSS match set.'

  describe aws_waf_xss_match_sets do
    it { should exist }
    its('names') { should include aws_waf_xss_match_set_name }
    its('xss_match_set_ids') { should include aws_waf_xss_match_set_id }
  end
end
