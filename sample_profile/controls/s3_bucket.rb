title 'Test AWS S3 Buckets in bulk2'


control 'aws-s3-buckets-1.0' do
  impact 1.0
  title 'Ensure AWS S3 Buckets plural resource has the correct properties.'
  describe aws_s3_buckets do
    it { should exist }
    its('count') { should be >= 1 }
    its('bucket_names') { should_not include 'not-there-hopefully' }
  end
end