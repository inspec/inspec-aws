describe aws_route53_hosted_zone(id: "Z0659249DKX791K6SOW") do
    it { should exist }
end

describe aws_route53_hosted_zone(id: "Z0659249DKX791K6SOW") do
    its('hosted_zone.id') { should eq '/hostedzone/Z0659249DKX791K6SOW' }
    its('hosted_zone.name') { should eq 'aws_progress_test1.com.' }
    its('hosted_zone.caller_reference') { should eq 'd07f9347-f52b-4b11-8040-667d923a95bd' }
    its('hosted_zone.config.comment') { should eq 'test1' }
    its('hosted_zone.config.private_zone') { should eq false }
    its('hosted_zone.resource_record_set_count') { should eq 3 }
    its('hosted_zone.linked_service.service_principal') { should be_empty }
    its('hosted_zone.inked_service.description') { should be_empty }
end

describe aws_route53_hosted_zone(id: "Z0659249DKX791K6SOW") do
    its('delegation_set.id') { should be_empty }
    its('delegation_set.caller_reference') { should be_empty }
    its('delegation_set.name_servers') { should include "ns-1385.awsdns-45.org" }
end

describe aws_route53_hosted_zone(id: "Z0659249DKX791K6SOW") do
    its('vp_cs') { should be_empty }
end

describe aws_route53_hosted_zone(id: "dummy") do
    it { should_not exist }
end