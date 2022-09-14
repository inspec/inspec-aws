aws_route53_zone_id = input(:aws_route53_zone_id, value: '', description: '')
aws_route53_zone_name = input(:aws_route53_zone_name, value: '', description: '')

title 'Ensure the hosted zone have the correct properties.'

control 'aws-hosted-zones-1.0' do
  impact 1.0
  title 'Ensure the hosted zone have the correct properties.'

  describe aws_hosted_zones do
    it { should exist }
    its('count') { should >= 1 }
  end

  describe aws_hosted_zones do
    its('ids') { should include aws_route53_zone_id }
    its('names') { should include aws_route53_zone_name }
    its('caller_references') { should_not be_empty }
    its('configs') { should_not be_empty }
    its('resource_record_set_counts') { should_not include 1 }
    its('linked_services') { should_not be_empty }
  end
end
