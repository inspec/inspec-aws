aws_waf_ip_set_name = attribute(:aws_waf_ipset_id, value: 'tfIPSet')
aws_waf_ipset_id = attribute(:aws_waf_ipset_name, value: 'df3af4d8-26bd-4083-8d77-a58bef4184d1')

control 'aws_waf_ip_set-1.0' do
  impact 1.0
  title 'Test the properties of a WAF IP Set.'
  describe aws_waf_ip_set(ip_set_id: aws_waf_ipset_id) do
    it { should exist }
    its('name') { should eq aws_waf_ip_set_name }
    its('ip_set_id') { should eq aws_waf_ipset_id }
  end
end