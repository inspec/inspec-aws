describe aws_elasticloadbalancingv2_target_group(target_group_arns: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:targetgroup/test1/05fa0cc6c7757ea3') do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_target_group(target_group_arns: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:targetgroup/test1/05fa0cc6c7757ea3') do
      its('target_group_arn') { should eq "arn:aws:elasticloadbalancing:us-east-2:112758395563:targetgroup/test1/05fa0cc6c7757ea3" }
      its('target_group_name') { should eq "test1" }
      its('protocol') { should eq "HTTP" }
      its('port') { should eq 80 }
      its('vpc_id') { should eq "vpc-6d9d7505" }
      its('health_check_protocol') { should eq "HTTP" }
      its('health_check_port') { should eq "traffic-port" }
      its('health_check_enabled') { should eq true }
      its('health_check_protocol') { should eq "HTTP" }
      its('health_check_interval_seconds') { should eq 30 }
      its('health_check_timeout_seconds') { should eq 5 }
      its('healthy_threshold_count') { should eq 5 }
      its('unhealthy_threshold_count') { should eq 2 }
      its('health_check_path') { should eq "/" }
      its('matcher.http_code') { should eq "200" }
      its('matcher.grpc_code') { should be_empty }
      its('load_balancer_arns') { should include "arn:aws:elasticloadbalancing:us-east-2:112758395563:loadbalancer/app/test1/4d099ca3e6de545d" }
      its('target_type') { should eq "instance" }
      its('protocol_version') { should eq "HTTP1" }
  end