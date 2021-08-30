control 'aws-ec2-prefix-lists-1.0' do
  impact 1.0
  title 'List all the prefix lists.'

  describe aws_ec2_prefix_lists do
    it { should exist }
  end

  describe aws_ec2_prefix_lists do
    its('prefix_list_ids') { should include '' }
    its('address_families') { should include '' }
    its('states') { should include '' }
    its('state_messages') { should include '' }
    its('prefix_list_arns') { should include '' }
    its('prefix_list_names') { should include '' }
    its('max_entries') { should include '' }
    its('versions') { should include '' }
    its('tags') { should include '' }
    its('owner_ids') { should include '' }
  end
end
