# frozen_string_literal: true

skip_control 'aws_cloudwatch_logs_destination-1.0' do
  impact 1.0
  title 'Describes the AWS cloudwatch logs log-stream.'
  describe aws_cloudwatch_logs_destination(destination_name_prefix: "testDestination") do
    it { should exist }
    its('destination_name') { should eq 'testDestination' }
    its('target_arn') { should eq 'arn:aws:kinesis:us-east-1:112758395563:stream/Nirbhay-test' }
    its('role_arn') { should eq "arn:aws:iam::112758395563:role/CWLtoKinesisRole" }
    its('access_policie') { should eq nil }
    its('arn') { should eq "arn:aws:logs:us-east-1:112758395563:destination:testDestination" }
  end
end
