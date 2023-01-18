aws_launch_template_name = input(:launch_template_name, value: '', description: 'The AWS  Launch Template Name.')

title 'Test aws launch template'

control 'aws-launch-template-1.0' do
  title 'Ensure AWS launch templates has the correct properties.'

  describe aws_ec2_launch_template(aws_launch_template_name: aws_launch_template_name) do
    it {should exist}
    its('launch_template_name'){ should eq aws_launch_template_name }
  end
end
