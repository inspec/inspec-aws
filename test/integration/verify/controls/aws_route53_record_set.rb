title 'Test single AWS Route53 record set'

hosted_zone_id = input(:aws_route53_hosted_zone_id, value: '', description: '')
start_record_name = input(:aws_route52_record_set_name, value: '', description: 'The AWS Route53 record set identifier.')

control 'aws-route53-record-set-1.0' do
  title 'Ensure AWS Route53 record set has the correct properties.'

  describe aws_route53_record_set(hosted_zone_id: hosted_zone_id, start_record_name: start_record_name) do
    it { should exist }
  end

  describe aws_route53_record_set(hosted_zone_id: hosted_zone_id, start_record_name: start_record_name) do
    its('name') { should eq start_record_name }
    its('type') { should eq 'A' }
    its('resource_records.first.value') { should eq '192.0.0.2' }
  end

  describe aws_route53_record_set(hosted_zone_id: "dummy", start_record_name: "dummy") do
    it { should_not exist }
  end
end
