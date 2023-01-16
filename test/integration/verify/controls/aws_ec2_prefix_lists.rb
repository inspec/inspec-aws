title 'Test single EC2 prefix list'

skip_control 'aws-ec2-prefix-lists-1.0' do
  title 'Ensure EC2 prefix list plural resource has the correct properties.'

  describe aws_ec2_prefix_lists do
    it { should exist }
  end

  describe aws_ec2_prefix_lists do
    its('owner_ids') {should include 'OwnerID'}
    its('prefix_list_arns') {should include 'PrefixListARN'}
    its('address_families') {should include 'IPv4'}
    its('prefix_list_names') {should include 'PrefixListName'}
  end
end


