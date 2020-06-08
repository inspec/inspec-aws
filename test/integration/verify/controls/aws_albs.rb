title 'Test AWS ALBs'

aws_alb_arn = attribute(:aws_alb_arn, default: '', description: 'The AWS ALB arn.')
region = attribute(:aws_region, default: '', description: 'The AWS region.')

control 'aws-albs-1.0' do

  impact 1.0
  title 'Ensure AWS ALBs have the correct properties.'

  describe aws_albs do
    it                         { should exist }
    its ('load_balancer_arns') { should include aws_alb_arn }
  end
end
