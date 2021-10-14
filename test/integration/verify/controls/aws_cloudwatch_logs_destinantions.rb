# frozen_string_literal: true

skip_control 'aws_cloudwatch_logs_destinations-1.0' do
  impact 1.0
  title 'Describes the AWS cloudwatch logs log-stream.'
  describe aws_cloudwatch_logs_destinations do
    it { should exist }
    its('destination_names') { should include 'testDestination' }
    its('target_arns') { should include 'arn:aws:kinesis:us-east-1:112758395563:stream/Nirbhay-test' }
    its('role_arns') { should include "arn:aws:iam::112758395563:role/CWLtoKinesisRole" }
    its('access_policies') { should include nil }
    its('arns') { should include "arn:aws:logs:us-east-1:112758395563:destination:testDestination" }
  end
end
