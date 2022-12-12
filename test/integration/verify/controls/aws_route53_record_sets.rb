title 'Test Plural AWS Route53 record set'

hosted_zone_id = input(:aws_route53_hosted_zone_id, value: '', description: '')

control 'aws-route53-record-sets-1.0' do
  title 'Ensure AWS Route53 record sets has the correct properties.'
  
  describe aws_route53_record_sets(hosted_zone_id: hosted_zone_id) do
    it { should exist }
  end

  describe aws_route53_record_sets(hosted_zone_id: hosted_zone_id) do
    its('names') { should include 'integration.test.' }
    its('types') { should include 'A' }
    its('set_identifiers') { should_not be_empty }
    its('weights') { should_not be_empty }
    its('regions') { should_not be_empty }
    its('geo_locations') { should_not be_empty }
    its('failovers') { should_not be_empty }
    its('multi_value_answers') { should_not be_empty }
    its('ttls') { should_not be_empty }
    its('resource_records') { should_not be_empty }
    its('alias_targets') { should_not be_empty }
    its('health_check_ids') { should_not be_empty }
    its('traffic_policy_instance_ids') { should_not be_empty }
  end

  describe aws_route53_record_sets(hosted_zone_id: "dummy") do
    it { should_not exist }
  end
end
