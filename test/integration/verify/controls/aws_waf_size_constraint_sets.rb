aws_waf_size_constraint_set_name = attribute(:aws_waf_ipset_id, value: '')
aws_waf_size_constraint_set_id = attribute(:aws_waf_ipset_name, value: '')

control 'aws_waf_size_constraint_sets-1.0' do
  impact 1.0
  title 'Test the properties of all the WAF Size Constraints.'

  describe aws_waf_size_constraint_sets do
    it { should exist }
    its('names') { should include aws_waf_size_constraint_set_name }
    its('size_constraint_set_ids') { should include aws_waf_size_constraint_set_id }
  end
end
