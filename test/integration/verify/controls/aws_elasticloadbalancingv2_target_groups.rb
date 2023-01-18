aws_target_group_arn = input(:aws_target_group_arn, value: '', description: '')

control 'aws-elbv2-target-groups-1.0' do
  title 'Ensure AWS ELBv2 Target Groups has the correct properties.'

  describe aws_elasticloadbalancingv2_target_groups do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_target_groups do
    its('target_group_arns') { should include aws_target_group_arn }
    its('target_group_names') { should include 'tf-example-lb-tg' }
    its('protocols') { should include 'HTTP' }
    its('ports') { should include 80 }
    its('health_check_protocols') { should include 'HTTP' }
    its('health_check_ports') { should include 'traffic-port' }
    its('health_check_enableds') { should include true }
    its('health_check_protocols') { should include 'HTTP' }
    its('health_check_interval_seconds') { should include 30 }
    its('health_check_timeout_seconds') { should include 5 }
    its('healthy_threshold_counts') { should include 5 }
    its('unhealthy_threshold_counts') { should include 2 }
    its('health_check_paths') { should include '/' }
    its('matchers') { should_not be_empty }
    its('target_types') { should include 'instance' }
    its('protocol_versions') { should include 'HTTP1' }
  end
end
