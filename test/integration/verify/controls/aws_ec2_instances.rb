title 'Test AWS EC2 Instances in bulk'

aws_default_vpc_id = input(:aws_default_vpc_id, value: '', description: 'The AWS region default VPC ID.')
aws_vm_size = input(:aws_vm_size, value: '', description: 'The AWS EC2 Instance type.')
aws_instance_id = input(:aws_instance_id, value: '', description: 'The AWS EC2 Instance ID.')

control 'aws-ec2-instances-1.0' do

  impact 1.0
  title 'Ensure AWS EC2 plural resource has the correct properties.'

  describe aws_ec2_instances do
    it { should exist }
    its('count') { should be <= 100 }
    its('instance_ids') { should include aws_instance_id }
    its('vpc_ids') { should include aws_default_vpc_id }
    its('instance_types') { should include aws_vm_size }
  end

end