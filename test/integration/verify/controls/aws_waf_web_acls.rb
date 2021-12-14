aws_waf_web_acl_id = attribute(aws_waf_web_acl_id, value: '', description: '')
aws_waf_web_acl_name = attribute(aws_waf_web_acl_name, value: '', description: '')

title 'Ensure the web acls have the correct properties.'

control 'aws-waf-web-acls-1.0' do
  impact 1.0

  describe aws_waf_web_acls do
    it { should exist }
  end

  describe aws_waf_web_acls do
    its('web_acl_ids') { should include aws_waf_web_acl_id }
    its('names') { should include aws_waf_web_acl_name }
  end
end