control 'aws-ec2-prefix-list-1.0' do
  impact 1.0
  title 'Describes one or more prefix list.'

  describe aws_ec2_prefix_list(prefix_list_id: "test1") do
    it { should exist }
  end

  describe aws_ec2_prefix_list(prefix_list_id: "test1") do
    its('prefix_list_id') { should eq '' }
    its('address_family') { should eq '' }
    its('state') { should eq '' }
    its('state_message') { should eq '' }
    its('prefix_list_arn') { should eq '' }
    its('prefix_list_name') { should eq '' }
    its('max_entries') { should eq '' }
    its('version') { should eq '' }
    its('tags') { should eq '' }
    its('owner_id') { should eq '' }
  end

  describe aws_ec2_prefix_list(prefix_list_id: "dummy") do
    it { should_not exist }
  end
end

