aws_waf_web_acl_metric_name = attribute(:aws_waf_web_acl_metric_name, value: '')
aws_waf_web_acl_id = attribute(:aws_waf_web_acl_id, value: '')

control 'aws_waf_web_acl-1.0' do
  impact 1.0
  title 'Test the properties of single WAF ACL.'
  
  describe aws_waf_web_acl(web_acl_id: aws_waf_web_acl_id) do
    it { should exist }
    its('name') { should eq aws_waf_web_acl_metric_name }
    its('web_acl_id') { should eq aws_waf_web_acl_id }
  end
end