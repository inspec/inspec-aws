aws_waf_byte_match_set_name = attribute(:aws_waf_byte_match_set_name, value: '')
byte_match_set_ids = attribute(:byte_match_set_ids, value: '')

control 'aws_waf_byte_match_sets-1.0' do
  impact 1.0
  title 'Test the properties of all the WAF Byte Match Sets.'
  describe aws_waf_byte_match_sets do
    it { should exist }
    its('names') { should include aws_waf_byte_match_set_name }
    its('byte_match_set_ids') { should include byte_match_set_ids }
  end
end

