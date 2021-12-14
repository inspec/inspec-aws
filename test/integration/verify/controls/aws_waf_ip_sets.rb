aws_waf_ipset_id = attribute(aws_waf_ipset_id, value: '', description: '')
aws_waf_ipset_name = attribute(aws_waf_ipset_name, value: '', description: '')

title 'Ensure the ip sets have the correct properties.'

control 'aws-waf-ip-sets-1.0' do
  impact 1.0

  describe aws_waf_ip_sets do
    it { should exist }
  end

  describe aws_waf_ip_sets do
    its('ip_set_ids') { should include aws_waf_ipset_id }
    its('names') { should include aws_waf_ipset_name }
  end
end
