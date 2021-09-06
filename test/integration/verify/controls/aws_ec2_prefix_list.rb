title 'Test single EC2 prefix list'
control 'aws-ec2-prefix-list-1.0' do

  impact 1.0
  title 'Ensure EC2 prefix list resource has the correct properties.'

  describe aws_ec2_prefix_list(prefix_list_id: aws_ec2_prefix_list_id) do
    it { should exist }
    its('owner_id') {should eq 'AWS'}
    its('prefix_list_arn') {should eq 'arn:aws:ec2:us-east-2:aws:prefix-list/pl-4ca54025'}
    its('address_family') {should eq 'IPv4'}
    its('prefix_list_name') {should eq 'com.amazonaws.us-east-2.dynamodb'}
  end
end

