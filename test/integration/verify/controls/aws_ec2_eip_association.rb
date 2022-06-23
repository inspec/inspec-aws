aws_eip_association_id = input(:aws_eip_association_id, value: '', description: '')

control 'aws-ec2-eip-association-1.0' do
  impact 1.0
  title 'Test the singular resource of EC2 EIP Association.'

  describe aws_ec2_eip_association(association_id: aws_eip_association_id) do
    it { should exist }
  end

  describe aws_ec2_eip_association(association_id: aws_eip_association_id) do
    its('association_id') { should eq aws_eip_association_id }
  end

  describe aws_ec2_eip_association(association_id: 'dummy') do
    it { should_not exist }
  end
end