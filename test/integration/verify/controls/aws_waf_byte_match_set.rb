aws_waf_byte_match_set_id = input(:aws_waf_byte_match_set_id, value: '', description: '')
aws_waf_byte_match_set_name = input(:aws_waf_byte_match_set_name, value: '', description: '')

title 'Ensure the byte match set have the correct properties.'

control 'aws-waf-byte-match-set-1.0' do
  title 'Test the properties of a WAF Byte Match Set.'

  describe aws_waf_byte_match_set(byte_match_set_id: aws_waf_byte_match_set_id) do
    it { should exist }
  end

  describe aws_waf_byte_match_set(byte_match_set_id: aws_waf_byte_match_set_id) do
    its('byte_match_set_id') { should eq aws_waf_byte_match_set_id }
    its('name') { should eq aws_waf_byte_match_set_name }

    its('byte_match_tuples_field_to_matches') { should_not be_empty }
    its('byte_match_tuples_field_to_match_types') { should include 'HEADER' }
    its('byte_match_tuples_field_to_match_data') { should include 'referer' }
    its('byte_match_tuples_target_strings') { should include 'badrefer1' }
    its('byte_match_tuples_text_transformations') { should include 'NONE' }
    its('byte_match_tuples_positional_constraints') { should include 'CONTAINS' }
  end

  describe aws_waf_byte_match_set(byte_match_set_id: 'dummy') do
    it { should_not exist }
  end
end
