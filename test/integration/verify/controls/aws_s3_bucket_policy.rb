bucket_name = attribute(:bucket_name, value: '')

control 'aws-s3-bucket-policy-1.0' do

  impact 1.0
  title 'Test the properties of an S3 Bucket Policy.'
  
  describe aws_s3_bucket_policy(bucket: bucket_name) do
    it { should exist }
    its('policy') { should_not empty }
  end
end



