aws_waf_size_constraint_set_name = attribute(:aws_waf_ipset_id, value: 'tfsize_constraints')
aws_waf_size_constraint_set_id = attribute(:aws_waf_ipset_name, value: '6fa89ce7-6cfe-4be2-98e5-2c313ec0580f')

control 'aws_waf_size_constraint_set-1.0' do
  impact 1.0
  title 'Test the properties of a WAF Size Constraint.'
  describe aws_waf_size_constraint_set(size_constraint_set_id: aws_waf_size_constraint_set_id) do
    it { should exist }
    its('name') { should eq aws_waf_size_constraint_set_name }
    its('size_constraint_set_id') { should eq aws_waf_size_constraint_set_id }
  end
end