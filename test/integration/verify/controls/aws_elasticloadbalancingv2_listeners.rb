aws_ebs2_lb_arn = attribute(:aws_ebs2_lb_arn, value: '', description: '')
aws_ebs2_lb_listener_arn = attribute(:aws_ebs2_lb_listener_arn, value: '', description: '')


  describe aws_elasticloadbalancingv2_listeners(listener_arn: aws_ebs2_lb_listener_arn) do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_listeners(listener_arn: aws_ebs2_lb_listener_arn) do
    its('listener_arns') { should include aws_ebs2_lb_listener_arn }
    its('load_balancer_arns') { should include aws_ebs2_lb_arn }
    its('ports') { should include 80 }
    its('protocols') { should include "HTTP" }
    its('certificates') { should_not be_empty }
    its('ssl_policies') { should_not be_empty }
    its('default_actions') { should_not be_empty }
    its('alpn_policies') { should_not be_empty }
  end