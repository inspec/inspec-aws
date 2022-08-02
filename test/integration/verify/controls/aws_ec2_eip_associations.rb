aws_eip_association_id = input(:aws_eip_association_id, value: '', description: '')

control 'aws-ec2-eip-associations-1.0' do
  impact 1.0
  title 'Test the plural resource of EC2 EIP Association.'

  describe aws_ec2_eip_associations do
    it { should exist }
  end

  describe aws_ec2_eip_associations do
    its('association_ids') { should include aws_eip_association_id }
  end
end