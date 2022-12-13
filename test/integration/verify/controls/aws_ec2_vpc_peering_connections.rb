aws_vpc_peering_connection_id = input(:aws_vpc_peering_connection_id, value: '', description: '')

control 'aws-ec2-vpc-peering-connections-1.0' do
  title 'Test the properties of the aws ec2 vpc peer connections.'

  describe aws_ec2_vpc_peering_connections do
    it { should exist }
  end

  describe aws_ec2_vpc_peering_connections do
    its('accepter_vpc_infos') { should_not be_empty }
    its('expiration_times') { should_not be_empty }
    its('requester_vpc_infos') { should_not be_empty }
    its('statuses') { should_not be_empty }
    its('tags') { should_not be_empty }
    its('vpc_peering_connection_ids') { should include aws_vpc_peering_connection_id }
  end
end
