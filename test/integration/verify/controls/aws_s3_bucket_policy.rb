# frozen_string_literal: true
bucket_name = attribute(:bucket_name, value: '')
describe aws_s3_bucket_policy(bucket: bucket_name) do
  it { should exist }
  its('policy') { should_not empty }
end
