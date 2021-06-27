describe aws_route53_record_sets(hosted_zone_id: "Z0659249DKX791K6SOW") do
    it { should exist }
end

describe aws_route53_record_sets(hosted_zone_id: "Z0659249DKX791K6SOW") do
    its('names') { should include 'aws_progress_test1.com.' }
    its('types') { should include 'NS' }
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