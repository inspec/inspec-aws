title 'Test collection of AWS Launch Configurations'

config_name = input(:aws_launch_configuration_name, value: '', description: 'The AWS launch configuration name.')

control 'aws-launch-configurations-1.0' do
  title 'Ensure AWS Launch Configuration plural resource have the correct properties.'

  describe aws_launch_configurations() do
    it { should exist }
    its ('names') { should include config_name}
  end
end
