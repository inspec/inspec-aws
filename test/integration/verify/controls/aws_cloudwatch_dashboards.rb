dashboard_arns = attribute(:dashboard_arn, value: '', description: 'The AWS EC2 Instance type.')
dashboard_names = attribute(:dashboard_name, value: '', description: 'The AWS EC2 image id.')

title 'Test single AWS EC2 Dashboard'
control 'aws-cloudwatch-dashboard-1.0' do

  impact 1.0
  title 'Ensure AWS cloudwatch dashboards has the correct properties.'

  describe aws_cloudwatch_dashboard(dashboard_name: dashboard_names) do
    it { should exist }
    its('dashboard_arn') { should eq dashboard_arns }
    its('dashboard_name') { should eq dashboard_names }
  end
end

