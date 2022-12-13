aws_waf_ipset_id = input(:aws_waf_ipset_id, value: '', description: '')
aws_waf_ipset_name = input(:aws_waf_ipset_name, value: '', description: '')

title 'Ensure the ip set have the correct properties.'

control 'aws-waf-ip-set-1.0' do
  title 'Test the properties of a WAF IP Set.'

  describe aws_waf_ip_set(ip_set_id: aws_waf_ipset_id) do
    it { should exist }
  end

  describe aws_waf_ip_set(ip_set_id: aws_waf_ipset_id) do
    its('ip_set_id') { should eq aws_waf_ipset_id }
    its('name') { should eq aws_waf_ipset_name }

    its('ip_set_descriptors_types') { should include 'IPV4' }
    its('ip_set_descriptors_values') { should include '10.0.0.0/16' }
  end
end
