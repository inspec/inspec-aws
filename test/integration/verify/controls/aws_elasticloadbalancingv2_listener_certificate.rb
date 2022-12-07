aws_elb2_listener_arn = input(:aws_elb2_listener_arn, value: '', description: '')
aws_elb2_certificate_arn = input(:aws_elb2_certificate_arn, value: '', description: '')

control 'aws-elb2-listener-certificate-1.0' do
  impact 1.0
  title 'Ensure AWS ELBV2 Listener Certificate has the correct properties.'

  describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: aws_elb2_listener_arn) do
    it { should exist }
  end

  describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: aws_elb2_listener_arn) do
    its('certificate_arn') { should eq aws_elb2_certificate_arn }
    its('is_default') { should eq true }
  end

  describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'dummy') do
    it { should_not exist }
  end
end