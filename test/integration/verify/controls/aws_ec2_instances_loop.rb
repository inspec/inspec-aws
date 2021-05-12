title 'Test AWS VPC EC2 Instances in bulk using plural and singular resources'

aws_instance_id = attribute(:aws_instance_id, default: '', description: 'The AWS EC2 Instance ID.')
aws_vm_name = attribute(:aws_vm_name, default: '', description: 'The AWS EC2 Instance name.')
aws_vm_size = attribute(:aws_vm_size, default: '', description: 'The AWS EC2 Instance type.')
aws_ec2_ami_id = attribute(:aws_ec2_ami_id, default: '', description: 'The AWS EC2 image id.')

control 'aws-ec2-instances-loop-1.0' do

  impact 1.0
  title 'Loop across AWS EC2 Instances plural resource using singular resource for detail.'


  aws_ec2_instances.instance_ids.each do |instance|
    describe aws_ec2_instance(instance_id: instance) do
      it { should exist }
      its('state') { should be_in ['pending', 'running', 'shutting-down', 'terminated', 'stopping', 'stopped'] }
    end
  end

  aws_ec2_instances.where { instance_id == aws_instance_id }.instance_ids.each do |instance|
    describe aws_ec2_instance(instance_id: instance) do
      it { should exist }
      its('instance_type') { should eq aws_vm_size }
      its('image_id') { should eq aws_ec2_ami_id }
      its('state') { should be_in ['pending', 'running', 'shutting-down', 'terminated', 'stopping', 'stopped'] }
      its('tags') { should include(key: 'Name', value: aws_vm_name) }
      it { should have_roles }
    end
  end
end