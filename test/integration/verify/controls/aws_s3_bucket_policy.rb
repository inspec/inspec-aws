bucket_name = input(:bucket_name, value: '', description: '')

control 'aws-s3-bucket-policy-1.0' do
  impact 1.0
  title 'Test the properties of an S3 Bucket Policy.'
  
  describe aws_s3_bucket_policy(bucket: bucket_name) do
    it { should exist }
    its('Sid') { should eq 'IPAllow' }
    its('Effect') { should eq 'Deny' }
    its('Principal') { should eq '*' }
  end
end



