aws_waf_byte_match_set_name = attribute(:aws_waf_byte_match_set_name, value: '')
byte_match_set_ids = attribute(:byte_match_set_ids, value: '')

control 'aws_waf_byte_match_set-1.0' do
  impact 1.0
  title 'Test the properties of a WAF BYte Match Set.'
  describe aws_waf_byte_match_set(byte_match_set_id: byte_match_set_ids) do
    it { should exist }
    its('name') { should eq aws_waf_byte_match_set_name }
    its('byte_match_set_id') { should eq byte_match_set_ids }
  end
end
