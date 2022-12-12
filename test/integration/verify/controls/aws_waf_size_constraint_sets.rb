aws_waf_size_constraint_set_id = input(aws_waf_size_constraint_set_id, value: '', description: '')
aws_waf_size_constraint_set_name = input(aws_waf_size_constraint_set_name, value: '', description: '')

title 'Ensure the size constraint sets have the correct properties.'

control 'aws-waf-size-constraint-sets-1.0' do
  title 'Test all the properties of the WAF size constraint set.'

  describe aws_waf_size_constraint_sets do
    it { should exist }
  end
  describe aws_waf_size_constraint_sets do
    its('size_constraint_set_ids') { should include aws_waf_size_constraint_set_id }
    its('names') { should include aws_waf_size_constraint_set_name }
  end
end
