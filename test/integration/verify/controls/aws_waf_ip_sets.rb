aws_waf_ipset_id = input(:aws_waf_ipset_id, value: '', description: '')
aws_waf_ipset_name = input(:aws_waf_ipset_name, value: '', description: '')

title 'Ensure the ip sets have the correct properties.'

control 'aws-waf-ip-sets-1.0' do
  title 'Test the properties of a WAF IP Sets.'

  describe aws_waf_ip_sets do
    it { should exist }
  end

  describe aws_waf_ip_sets do
    its('ip_set_ids') { should include aws_waf_ipset_id }
    its('names') { should include aws_waf_ipset_name }
  end
end
