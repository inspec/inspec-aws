aws_target_group_arn = attribute(:aws_target_group_arn, value: '', description: '')

control 'aws-elbv2-target-groups-1.0' do

  impact 1.0
  title 'Ensure AWS ELBv2 Target Groups has the correct properties.'

  describe aws_elasticloadbalancingv2_target_groups(target_group_arns: aws_target_group_arn) do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_target_groups(target_group_arns: aws_target_group_arn) do
      its('target_group_arns') { should include aws_target_group_arn }
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
end