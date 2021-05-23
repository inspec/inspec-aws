describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:listener/app/test-alb/26a69087e2cecd85/04af269ce8a29579') do
  it { should_not exist }
end

describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:listener/app/test-alb/26a69087e2cecd85/04af269ce8a29579') do
  its('certificate_arns') { should eq "test" }
  its('is_defaults') { should eq true }
end