title 'Test AWS ALBs'

aws_alb_arn = input(:aws_alb_arn, value: '', description: 'The AWS ALB arn.')

control 'aws-albs-1.0' do
  title 'Ensure AWS ALBs have the correct properties.'

  describe aws_albs do
    it                         { should exist }
    its ('load_balancer_arns') { should include aws_alb_arn }
  end
end
