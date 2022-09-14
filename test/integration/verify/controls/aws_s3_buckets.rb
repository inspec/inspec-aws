title 'Test AWS S3 Buckets in bulk'

aws_bucket_public_name = input(:aws_bucket_public_name, value: '', description: 'The AWS bucket name.')
aws_bucket_private_name = input(:aws_bucket_private_name, value: '', description: 'The AWS bucket name.')

control 'aws-s3-buckets-1.0' do
  impact 1.0
  title 'Ensure AWS S3 Buckets plural resource has the correct properties.'

  describe aws_s3_buckets do
    it { should exist }
    its('count') { should be >= 1 }
    its('bucket_names') { should include aws_bucket_public_name }
    its('bucket_names') { should include aws_bucket_private_name }
    its('bucket_names') { should_not include 'not-there-hopefully' }
    its('tags')         { should include('Environment' => "Dev",
                                         'Name' => aws_bucket_public_name)}
  end

end
