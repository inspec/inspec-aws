aws_waf_ip_set_name = attribute(:aws_waf_ipset_id, value: 'tfIPSet')
aws_waf_ipset_id = attribute(:aws_waf_ipset_name, value: 'df3af4d8-26bd-4083-8d77-a58bef4184d1')

control 'aws_waf_ip_sets-1.0' do
  impact 1.0
  title 'Test the properties of all the WAF IP Sets.'
  describe aws_waf_ip_sets do
    it { should exist }
    its('names') { should include aws_waf_ip_set_name }
    its('ip_set_ids') { should include aws_waf_ipset_id }
  end
end
