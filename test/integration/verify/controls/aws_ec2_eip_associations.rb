aws_association_id = attribute('aws_association_id', value: '', description: '')

control 'aws-ec2-eip-associations-1.0' do
  impact 1.0
  title 'Specifies an Elastic IP (EIP) address and can, optionally, associate it with an Amazon EC2 instance.'

  describe aws_ec2_eip_associations do
    it { should exist }
  end

  describe aws_ec2_eip_associations do
    its('association_ids') { should include aws_association_id }
  end
end