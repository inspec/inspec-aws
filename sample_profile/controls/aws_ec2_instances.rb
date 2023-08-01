title 'Test AWS EC2 Instances in bulk'

control 'aws-ec2-instances-1.0' do
  title 'Ensure AWS EC2 plural resource has the correct properties.'

  describe aws_ec2_instances do
    it { should exist }
    its('count') { should be <= 100 }
  end

  aws_ec2_instances.where(tags: /"Name"=>/).instance_ids.each do |id|
    describe aws_ec2_instance(id) do
      it { should exist }
    end
  end
end
