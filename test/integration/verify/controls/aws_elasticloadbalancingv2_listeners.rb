describe aws_elasticloadbalancingv2_listeners(listener_arn: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:listener/app/test-alb/26a69087e2cecd85/04af269ce8a29579') do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_listeners(listener_arn: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:listener/app/test-alb/26a69087e2cecd85/04af269ce8a29579') do
    its('listener_arns') { should include "arn:aws:elasticloadbalancing:us-east-2:112758395563:listener/app/test-alb/26a69087e2cecd85/04af269ce8a29579" }
    its('load_balancer_arns') { should include "arn:aws:elasticloadbalancing:us-east-2:112758395563:loadbalancer/app/test-alb/26a69087e2cecd85" }
    its('ports') { should include 80 }
    its('protocols') { should include "HTTP" }
    its('certificates') { should_not be_empty }
    its('ssl_policies') { should_not be_empty }
    its('default_actions') { should_not be_empty }
    its('alpn_policies') { should_not be_empty }
  end