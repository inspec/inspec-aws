aws_elbv2_load_balancer_arn = attribute(:load_balancer_arn, value: '', description: '')

control 'aws-eelbv2-load-balancer-1.0' do

  impact 1.0
  title 'Ensure AWS ELBv2 Load Balancer has the correct properties.'

  describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: aws_elbv2_load_balancer_arn) do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_load_balancer(load_balancer_arn: aws_elbv2_load_balancer_arn) do
      its('load_balancer_arn') { should eq aws_elbv2_load_balancer_arn }
      its('canonical_hosted_zone_id') { should eq "Z3AADJGX6KTTL2" }
      # its('created_time') { should eq "2021-05-17 18:01:12.78 UTC" }
      its('load_balancer_name') { should eq "test-lb-tf-i" }
      its('scheme') { should eq "internet-facing" }
      its('state.code') { should eq "active" }
      its('state.reason') { should be_empty }
      its('type') { should eq "application" }
      its('availability_zones') { should_not be_empty }
      its('availability_zones.first.zone_name') { should eq "us-east-2b" }
      its('availability_zones.first.outpost_id') { should be_empty }
      its('availability_zones.first.load_balancer_addresses') { should be_empty }
      its('ip_address_type') { should eq "ipv4" }
      its('customer_owned_ipv_4_pool') { should be_empty }
  end
end