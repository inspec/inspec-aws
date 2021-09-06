title 'Test single EC2 prefix list'
control 'aws-ec2-prefix-list-1.0' do

  impact 1.0
  title 'Ensure EC2 prefix list resource has the correct properties.'

  describe aws_ec2_prefix_lists do
    it { should exist }
    its('owner_ids') {should include 'AWS'}
    its('prefix_list_arns') {should include 'arn:aws:ec2:us-east-2:aws:prefix-list/pl-4ca54025'}
    its('address_families') {should include 'IPv4'}
    its('prefix_list_names') {should include 'com.amazonaws.us-east-2.dynamodb'}
  end
end


