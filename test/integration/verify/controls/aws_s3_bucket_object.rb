title 'Test single AWS S3 Bucket Object'

aws_s3_bucket_object_public = input(:aws_s3_bucket_object_public, value: '', description: 'The AWS bucket object key.')
aws_s3_bucket_object_private = input(:aws_s3_bucket_object_private, value: '', description: 'The AWS bucket object key.')
aws_bucket_public_objects_name = input(:aws_bucket_public_objects_name, value: '', description: 'The AWS bucket.')

control 'aws-s3-bucket-object-1.0' do
  title 'Ensure AWS S3 Bucket Object has the correct properties.'

  describe aws_s3_bucket_object(bucket_name: aws_bucket_public_objects_name, key: aws_s3_bucket_object_public) do
    it { should exist }
    it { should be_public }
    its('object_acl.count') { should eq 2 }
    its('content_length') { should be > 10 }
  end

  describe aws_s3_bucket_object(bucket_name: aws_bucket_public_objects_name, key: aws_s3_bucket_object_private) do
    it { should exist }
    it { should_not be_public }
    its('object_acl.count') { should eq 1 }
  end

  describe aws_s3_bucket_object(bucket_name: aws_bucket_public_objects_name, key: 'not_there') do
    it { should_not exist }
  end

  describe aws_s3_bucket_object(bucket_name: 'not_there', key: 'not_there_also') do
    it { should_not exist }
  end
end
