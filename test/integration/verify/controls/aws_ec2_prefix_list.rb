title 'Test single EC2 prefix list'

skip_control 'aws-ec2-prefix-list-1.0' do
  impact 1.0
  title 'Ensure EC2 prefix list singular resource has the correct properties.'

  describe aws_ec2_prefix_list(prefix_list_id: 'PrefixListID') do
    it { should exist }
  end

  describe aws_ec2_prefix_list(prefix_list_id: 'PrefixListID') do
    its('owner_id') {should eq 'OwnerID'}
    its('prefix_list_arn') {should eq 'PrefixListARN'}
    its('address_family') {should eq 'IPv4'}
    its('prefix_list_name') {should eq 'PrefixListName'}
  end
end

