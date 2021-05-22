describe aws_route53_hosted_zones do
    it { should exist }
end

describe aws_route53_hosted_zones do
    its('ids') { should include '/hostedzone/Z0659249DKX791K6SOW' }
    its('names') { should include 'aws_progress_test1.com.' }
    its('caller_references') { should include 'd07f9347-f52b-4b11-8040-667d923a95bd' }
    its('configs') { should_not be_empty }
    its('resource_record_set_counts') { should include 3 }
    its('linked_services') { should_not be_empty }
end