dashboard_arns = input(:dashboard_arn, value: '', description: 'The AWS EC2 Instance type.')
dashboard_names = input(:dashboard_name, value: '', description: 'The AWS EC2 image id.')

title 'Test plural AWS CloudWatch Dashboard'

control 'aws-cloudwatch-dashboards-1.0' do
  impact 1.0
  title 'Ensure AWS cloudwatch dashboards has the correct properties.'

  describe aws_cloudwatch_dashboards do
    it { should exist }
    its('dashboard_arns') { should include dashboard_arns }
    its('dashboard_names') { should include dashboard_names }
  end
end

