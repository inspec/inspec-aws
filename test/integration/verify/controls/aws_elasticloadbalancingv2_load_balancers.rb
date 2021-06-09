aws_elbv2_load_balancer_arn = attribute(:load_balancer_arn, value: '', description: '')

control 'aws-eelbv2-load-balancers-1.0' do

  impact 1.0
  title 'Ensure AWS ELBv2 Load Balancers has the correct properties.'

  describe aws_elasticloadbalancingv2_load_balancers(load_balancer_arn: aws_elbv2_load_balancer_arn) do
    it { should exist }
  end
  
  describe aws_elasticloadbalancingv2_load_balancers(load_balancer_arn: aws_elbv2_load_balancer_arn) do
      its('load_balancer_arns') { should include aws_elbv2_load_balancer_arn }
      its('canonical_hosted_zone_ids') { should include "Z3AADJGX6KTTL2" }
      its('load_balancer_names') { should include "test-lb-tf-i" }
      its('schemes') { should include "internet-facing" }
      its('types') { should include "application" }
      its('availability_zones') { should_not be_empty }
      its('ip_address_types') { should include "ipv4" }
      its('customer_owned_ipv_4_pools') { should_not be_empty }
  end
end