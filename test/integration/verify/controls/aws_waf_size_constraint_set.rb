aws_waf_size_constraint_set_id = input(aws_waf_size_constraint_set_id, value: '', description: '')
aws_waf_size_constraint_set_name = input(aws_waf_size_constraint_set_name, value: '', description: '')

title 'Ensure the size constraint set have the correct properties.'

control 'aws-waf-size-constraint-set-1.0' do
  title 'Test the properties of the WAF size constraint set.'

  describe aws_waf_size_constraint_set(size_constraint_set_id: aws_waf_size_constraint_set_id) do
    it { should exist }
  end
  describe aws_waf_size_constraint_set(size_constraint_set_id: aws_waf_size_constraint_set_id) do
    its('size_constraint_set_id') { should eq aws_waf_size_constraint_set_id }
    its('name') { should eq aws_waf_size_constraint_set_name }
    its('size_constraints_field_to_match_types') { should include 'BODY' }
    its('size_constraints_field_to_match_data') { should_not be_empty }
    its('size_constraints_text_transformations') { should include 'NONE' }
    its('size_constraints_comparison_operator') { should be_empty }
    its('size_constraints_sizes') { should include 4096 }
  end
end
