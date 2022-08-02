aws_waf_web_acl_id = input(aws_waf_web_acl_id, value: '', description: '')
aws_waf_web_acl_name = input(aws_waf_web_acl_name, value: '', description: '')

title 'Ensure the web acls have the correct properties.'

control 'aws-waf-web-acls-1.0' do
  impact 1.0
  title 'Test the properties of all WAF ACLs.'

  describe aws_waf_web_acls do
    it { should exist }
    its('web_acl_ids') { should include aws_waf_web_acl_id }
    its('names') { should include aws_waf_web_acl_name }
  end
end
