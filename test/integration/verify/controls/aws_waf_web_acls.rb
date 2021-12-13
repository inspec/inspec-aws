aws_waf_web_acl_metric_name = attribute(:aws_waf_web_acl_metric_name, value: '')
aws_waf_web_acl_id = attribute(:aws_waf_web_acl_id, value: '')

control 'aws_waf_web_acl-1.0' do
  impact 1.0
  title 'Test the properties of all the WAF ACLs.'
  
  describe aws_waf_web_acls do
    it { should exist }
    its('names') { should include aws_waf_web_acl_metric_name }
    its('web_acl_ids') { should include aws_waf_web_acl_id }
  end
end
