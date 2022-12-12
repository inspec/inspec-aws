aws_launch_template_name = input(:launch_template_name, value: '', description: 'The AWS  Launch Template Name.')

title 'Test AWS launch templates in bulk'

control 'aws-launch-templates-1.0' do
  title 'Ensure AWS launch templates resource has the correct properties.'

  describe aws_ec2_launch_templates do
    it { should exist }
    its('count') { should be 1 }
    its('launch_template_names') { should include aws_launch_template_name  }
  end
end
