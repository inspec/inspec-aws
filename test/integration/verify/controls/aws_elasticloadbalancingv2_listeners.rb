listener_arn = input(:listener_arn, value: '', description: '')
load_balancer_arn = input(:load_balancer_arn, value: '', description: '')

control 'aws-elbv2-listeners-1.0' do
  title 'Ensure AWS ELBv2 listeners has the correct properties.'
  
  describe aws_elasticloadbalancingv2_listeners(load_balancer_arn: load_balancer_arn) do
    it { should exist }
  end

  describe aws_elasticloadbalancingv2_listeners(load_balancer_arn: load_balancer_arn) do
    its('listener_arns') { should include listener_arn }
    its('load_balancer_arns') { should include load_balancer_arn }
    its('ports') { should include 80 }
    its('protocols') { should include 'HTTP' }
    its('certificates') { should_not be_empty }
    its('ssl_policies') { should_not be_empty }
    its('default_actions') { should_not be_empty }
    its('alpn_policies') { should_not be_empty }
  end
end
