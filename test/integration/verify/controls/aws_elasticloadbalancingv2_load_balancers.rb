describe aws_elasticloadbalancingv2_load_balancers(load_balancer_arn: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:loadbalancer/app/test1/4d099ca3e6de545d') do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_load_balancers(load_balancer_arn: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:loadbalancer/app/test1/4d099ca3e6de545d') do
      its('load_balancer_arns') { should include "arn:aws:elasticloadbalancing:us-east-2:112758395563:loadbalancer/app/test1/4d099ca3e6de545d" }
      its('dns_names') { should include "test1-1277654690.us-east-2.elb.amazonaws.com" }
      its('canonical_hosted_zone_ids') { should include "Z3AADJGX6KTTL2" }
      # its('created_times') { should include "2021-05-17 18:01:12.78 UTC" }
      its('load_balancer_names') { should include "test1" }
      its('schemes') { should include "internet-facing" }
      its('vpc_ids') { should include "vpc-6d9d7505" }
      # its('states.code') { should include "active" }
      # its('states.reason') { should be_empty }
      its('types') { should eq "application" }
  
      its('availability_zones') { should_not be_empty }
      # its('security_groups') { should include "sg-00dd73829ccf99146" }
      its('ip_address_types') { should include "ipv4" }
      its('customer_owned_ipv_4_pools') { should_not be_empty }
  end