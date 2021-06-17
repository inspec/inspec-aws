describe aws_route53_hosted_zone(id: "Z0659249DKX791K6SOW") do
    it { should exist }
end

describe aws_route53_hosted_zone(id: "Z0659249DKX791K6SOW") do
    its('id') { should eq '/hostedzone/Z0659249DKX791K6SOW' }
    its('name') { should eq 'aws_progress_test1.com.' }
    its('caller_reference') { should eq 'd07f9347-f52b-4b11-8040-667d923a95bd' }
    its('config.comment') { should eq 'test1' }
    its('config.private_zone') { should eq false }
    its('resource_record_set_count') { should eq 3 }
    its('linked_service.service_principal') { should be_empty }
    its('inked_service.description') { should be_empty }
end

describe aws_route53_hosted_zone(id: "dummy") do
    it { should_not exist }
end