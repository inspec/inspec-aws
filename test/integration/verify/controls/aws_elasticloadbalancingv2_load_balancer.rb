describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:loadbalancer/app/test1/4d099ca3e6de545d') do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: 'arn:aws:elasticloadbalancing:us-east-2:112758395563:loadbalancer/app/test1/4d099ca3e6de545d') do
      its('load_balancer_arn') { should eq "arn:aws:elasticloadbalancing:us-east-2:112758395563:loadbalancer/app/test1/4d099ca3e6de545d" }
      its('dns_name') { should eq "test1-1277654690.us-east-2.elb.amazonaws.com" }
      its('canonical_hosted_zone_id') { should eq "Z3AADJGX6KTTL2" }
      # its('created_time') { should eq "2021-05-17 18:01:12.78 UTC" }
      its('load_balancer_name') { should eq "test1" }
      its('scheme') { should eq "internet-facing" }
      its('vpc_id') { should eq "vpc-6d9d7505" }
      its('state.code') { should eq "active" }
      its('state.reason') { should be_empty }
      its('type') { should eq "application" }
  
      its('availability_zones') { should_not be_empty }
      its('availability_zones.first.zone_name') { should eq "us-east-2b" }
      its('availability_zones.first.subnet_id') { should eq "subnet-22043459" }
      its('availability_zones.first.outpost_id') { should be_empty }
  
      its('availability_zones.first.load_balancer_addresses') { should be_empty }
    #   its('availability_zones.first.load_balancer_addresses.first.ip_address') { should be_empty }
    #   its('availability_zones.first.load_balancer_addresses.first.allocation_id') { should be_empty }
    #   its('availability_zones.first.load_balancer_addresses.first.private_i_pv_4_address') { should be_empty }
    #   its('availability_zones.first.load_balancer_addresses.first.i_pv_6_address') { should be_empty }
  
      its('security_groups') { should include "sg-00dd73829ccf99146" }
      its('ip_address_type') { should eq "ipv4" }
      its('customer_owned_ipv_4_pool') { should be_empty }
  end