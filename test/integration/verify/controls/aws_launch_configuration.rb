title 'Test single AWS Launch Configuration'

config_name = input(:aws_launch_configuration_name, value: '', description: 'The AWS launch configuration name.')

control 'aws-launch-configuration-1.0' do
  title 'Ensure AWS Launch Configuration has the correct properties.'

  describe aws_launch_configuration(launch_configuration_name: config_name) do
    it { should exist }
    its ('name') { should eq config_name}
  end
end
