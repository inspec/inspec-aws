aws_instance_id = input(:aws_instance_id, value: '', description: 'The AWS EC2 Instance ID.')
aws_vm_name = input(:aws_vm_name, value: '', description: 'The AWS EC2 Instance name.')
aws_vm_size = input(:aws_vm_size, value: '', description: 'The AWS EC2 Instance type.')
aws_ec2_ami_id = input(:aws_ec2_ami_id, value: '', description: 'The AWS EC2 image id.')
aws_iam_role_name_for_ec2 = input(:aws_iam_role_name_for_ec2, value: '', description: 'The AWS EC2 IAM instance role name.')

title 'Test single AWS EC2 Instance.'

control 'aws-ec2-instance-1.0' do
  title 'Ensure AWS EC2 Instance has the correct properties.'

  describe aws_ec2_instance(instance_id: aws_instance_id) do
    it {should exist}
    its('instance_type'){ should eq aws_vm_size }
    its('image_id'){ should eq aws_ec2_ami_id }
    its('state') {should be_in ['pending', 'running', 'shutting-down', 'terminated', 'stopping', 'stopped']}
    its('tags') { should include(key: 'Name', value: aws_vm_name) }
    its('tags_hash') { should include('Name') }
    its('name') { should eq aws_vm_name }
    it { should have_roles }
    its('role') { should eq aws_iam_role_name_for_ec2 }
  end

  describe aws_ec2_instance(aws_instance_id) do
    it {should exist}
    its('instance_id'){ should eq aws_instance_id }
  end

  describe aws_ec2_instance(name: aws_vm_name) do
    it {should exist}
    its('instance_id') { should eq aws_instance_id }
  end
end
