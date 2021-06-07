aws_elbv2_load_balancer_arn = attribute(:aws_elbv2_load_balancer_arn, value: '', description: '')

control 'aws-eelbv2-load-balancers-1.0' do

  impact 1.0
  title 'Ensure AWS ELBv2 Load Balancers has the correct properties.'

  describe aws_elasticloadbalancingv2_load_balancers(load_balancer_arn: aws_elbv2_load_balancer_arn) do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_load_balancers(load_balancer_arn: aws_elbv2_load_balancer_arn) do
      its('load_balancer_arns') { should include aws_elbv2_load_balancer_arn }
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
end