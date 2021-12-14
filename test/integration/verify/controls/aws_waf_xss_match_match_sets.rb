aws_waf_xss_match_set_name = attribute(:aws_waf_ipset_id, value: 'tfsize_constraints')
aws_waf_xss_match_set_id = attribute(:aws_waf_ipset_name, value: '3901a561-ae05-4a6d-a139-6519f8819b98')

control 'aws_waf_size_constraint_sets-1.0' do
  impact 1.0
  title 'Test the properties of all WAF xss match set.'
  describe aws_waf_xss_match_sets do
    it { should exist }
    its('names') { should include aws_waf_xss_match_set_name }
    its('xss_match_set_ids') { should include aws_waf_xss_match_set_id }
  end
end
