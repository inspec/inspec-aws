describe aws_route53_record_set(hosted_zone_id: "Z0659249DKX791K6SOW", start_record_name: "record1.aws_progress_test1.com.") do
    it { should exist }
end

describe aws_route53_record_set(hosted_zone_id: "Z0659249DKX791K6SOW", start_record_name: "record1.aws_progress_test1.com.") do
    its('name') { should eq 'aws_progress_test1.com.' }
    its('type') { should eq 'NS' }
    its('resource_records.first.value') { should_not be_empty }
    its('resource_records.first.value') { should eq 'ns-1385.awsdns-45.org.' }
end

describe aws_route53_record_set(hosted_zone_id: "dummy", start_record_name: "dummy") do
    it { should_not exist }
end