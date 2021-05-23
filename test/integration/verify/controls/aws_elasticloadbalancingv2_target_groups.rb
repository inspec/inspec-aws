describe aws_elasticloadbalancingv2_target_groups(target_group_arns: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:targetgroup/test1/05fa0cc6c7757ea3') do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_target_groups(target_group_arns: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:targetgroup/test1/05fa0cc6c7757ea3') do
      its('target_group_arns') { should include "arn:aws:elasticloadbalancing:us-east-2:112758395563:targetgroup/test1/05fa0cc6c7757ea3" }
      its('target_group_names') { should include "test1" }
      its('protocols') { should include "HTTP" }
      its('ports') { should include 80 }
      its('vpc_ids') { should include "vpc-6d9d7505" }
      its('health_check_protocols') { should include "HTTP" }
      its('health_check_ports') { should include "traffic-port" }
      its('health_check_enableds') { should include true }
      its('health_check_protocols') { should include "HTTP" }
      its('health_check_interval_seconds') { should include 30 }
      its('health_check_timeout_seconds') { should include 5 }
      its('healthy_threshold_counts') { should include 5 }
      its('unhealthy_threshold_counts') { should include 2 }
      its('health_check_paths') { should include "/" }
      its('matchers') { should_not be_empty }
      # its('load_balancer_arns') { should include '["arn:aws:elasticloadbalancing:us-east-2:112758395563:loadbalancer/app/test1/4d099ca3e6de545d"]' }
      its('target_types') { should include "instance" }
      its('protocol_versions') { should include "HTTP1" }
  end