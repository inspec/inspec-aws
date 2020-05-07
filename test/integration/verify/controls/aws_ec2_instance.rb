title 'Test single AWS EC2 Instance'

aws_instance_id = attribute(:aws_instance_id, default: '', description: 'The AWS EC2 Instance ID.')
aws_vm_name = attribute(:aws_vm_name, default: '', description: 'The AWS EC2 Instance name.')
aws_vm_size = attribute(:aws_vm_size, default: '', description: 'The AWS EC2 Instance type.')
aws_ec2_ami_id = attribute(:aws_ec2_ami_id, default: '', description: 'The AWS EC2 image id.')

control 'aws-ec2-instance-1.0' do

  impact 1.0
  title 'Ensure AWS EC2 Instance has the correct properties.'

  describe aws_ec2_instance(instance_id: aws_instance_id) do
    it {should exist}
    its('instance_type'){ should eq aws_vm_size }
    its('image_id'){ should eq aws_ec2_ami_id }
    its('state') {should be_in ['pending', 'running', 'shutting-down', 'terminated', 'stopping', 'stopped']}
    its('tags') { should include(key: 'Name', value: aws_vm_name) }
    its('tags_hash') { should include("Name") }
    it { should_not have_roles }
  end

  describe aws_ec2_instance(aws_instance_id) do
    it {should exist}
    its('instance_id'){ should eq aws_instance_id }
  end

  describe aws_ec2_instance(name: aws_vm_name) do
    it {should exist}
    its('instance_id'){ should eq aws_instance_id }
  end

end