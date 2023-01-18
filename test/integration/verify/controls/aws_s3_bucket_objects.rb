aws_s3_bucket_object_public = input(:aws_s3_bucket_object_public, value: '', description: 'The AWS bucket object key.')
aws_bucket_public_objects_name = input(:aws_bucket_public_objects_name, value: '', description: 'The AWS bucket.')

control 'aws-s3-bucket-objects-1.0' do
  title 'Ensure AWS S3 Bucket Objects has the correct properties.'

  describe aws_s3_bucket_objects(bucket_name: aws_bucket_public_objects_name) do
    it { should exist }
  end

  describe aws_s3_bucket_objects(bucket_name: aws_bucket_public_objects_name) do
    its ('is_truncated') { should include false }
    its ('contents') { should_not be_empty }
    its ('names') { should include aws_bucket_public_objects_name }
    its ('prefixes') { should_not be_empty }
    its ('delimiters') { should include nil }
    its ('max_keys') { should include 1000 }
    its ('common_prefixes') { should_not be_empty }
    its ('encoding_types') { should include nil }
    its ('key_counts') { should include 2 }
    its ('continuation_tokens') { should include nil }
    its ('next_continuation_tokens') { should include nil }
    its ('start_afters') { should include nil }
  end

  describe aws_s3_bucket_objects(bucket_name: 'dummy') do
    it { should_not exist }
  end

  describe aws_s3_bucket_objects(bucket_name: aws_bucket_public_objects_name) do
    its ('contents_keys') { should include aws_s3_bucket_object_public }
    its ('contents_storage_classes') { should include "STANDARD" }
  end
end
