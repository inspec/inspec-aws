title 'Test single AWS S3 Bucket'

aws_bucket_public_name = input(:aws_bucket_public_name, value: '', description: 'The AWS bucket name.')
aws_bucket_public_region = input(:aws_s3_bucket_public_region, value: '', description: 'The AWS bucket region.')
aws_bucket_private_name = input(:aws_bucket_private_name, value: '', description: 'The AWS bucket private name.')
aws_bucket_auth_name = input(:aws_bucket_auth_name, value: '', description: 'The AWS bucket auth name.')
aws_bucket_acl_policy_name = input(:aws_bucket_acl_policy_name, value: '', description: 'The AWS bucket policy name.')
aws_bucket_logging_disabled = input(:aws_bucket_logging_disabled, value: '', description: 'The AWS bucket logging value.')
aws_bucket_log_sender_name = input(:aws_bucket_log_sender_name, value: '', description: 'The AWS bucket log sender name.')
aws_bucket_encryption_enabled = input(:aws_bucket_encryption_enabled, value: '', description: 'The AWS bucket encryption enabled value.')
aws_bucket_encryption_disabled = input(:aws_bucket_encryption_disabled, value: '', description: 'The AWS bucket decryption enabled value.')
aws_bucket_versioning_enabled = input(:aws_bucket_versioning_enabled, value: '', description: 'The AWS bucket versioning enabled value.')
aws_bucket_versioning_disabled = input(:aws_bucket_versioning_disabled, value: '', description: 'The AWS bucket versioning enabled value.')

control 'aws-s3-bucket-1.0' do
  impact 1.0
  title 'Ensure AWS S3 bucket has the correct properties.'

  describe aws_s3_bucket(bucket_name: aws_bucket_public_name) do
    it            { should exist }
    its('region') { should eq aws_bucket_public_region }
    its('tags')   { should include('Environment' => 'Dev',
                                   'Name' => aws_bucket_public_name)}
    it            { should be_public }
    it            { should have_secure_transport_enabled }
    its('bucket_lifecycle_rules') { should be_empty }
  end

  describe aws_s3_bucket(aws_bucket_public_name) do
    it            { should exist }
    its('region') { should eq aws_bucket_public_region }
    it            { should be_public }
  end

  describe aws_s3_bucket(bucket_name: 'non-existing-bucket-inspec-testing-aws-12345') do
    it                   { should_not exist }
    its('bucket_policy') { should be_empty }
    its('bucket_acl')    { should be_empty }
  end

  describe aws_s3_bucket(bucket_name: aws_bucket_private_name) do
    it { should exist }
    it { should_not be_public }
    it { should_not have_secure_transport_enabled }
    its('bucket_lifecycle_rules') { should_not be_empty }
  end

  aws_s3_bucket(bucket_name: aws_bucket_private_name).bucket_lifecycle_rules.each do |rule|
    describe rule do
      its('expiration.days') { should be >= 180 }
      its('status') { should eq 'Enabled' }
    end
  end

  describe aws_s3_bucket(bucket_name: aws_bucket_auth_name) do
    it { should exist }
    it { should be_public }
  end

  describe aws_s3_bucket(bucket_name: aws_bucket_acl_policy_name) do
    it { should exist }
    it { should be_public }
  end

  describe aws_s3_bucket(bucket_name: aws_bucket_encryption_enabled) do
    it { should exist }
    it { should have_value_encryption_enabled }
  end

  describe aws_s3_bucket(bucket_name: aws_bucket_encryption_disabled) do
    it { should exist }
    it { should_not have_value_encryption_enabled }
  end

  describe aws_s3_bucket(bucket_name: aws_bucket_versioning_enabled) do
    it { should exist }
    it { should have_versioning_enabled }
  end

  describe aws_s3_bucket(bucket_name: aws_bucket_versioning_disabled) do
    it { should exist }
    it { should_not have_versioning_enabled }
  end
  
  describe aws_s3_bucket(bucket_name: aws_bucket_log_sender_name) do
    it { should exist }
    it { should have_access_logging_enabled }
  end

  describe aws_s3_bucket(bucket_name: aws_bucket_logging_disabled) do
    it { should exist }
    it { should_not have_access_logging_enabled }
  end
end

control 'aws-s3-bucket-acl-policy-1.0' do

  #------------------- bucket_acl -------------------#
  describe "Bucket ACL: Public grants on a public bucket" do
    subject do
      aws_s3_bucket(bucket_name: aws_bucket_public_name).bucket_acl.select do |g|
        g.grantee.type == 'Group' && g.grantee.uri =~ /AllUsers/
      end
    end
    it { should_not be_empty }
  end

  describe "Bucket ACL: Public grants on a private bucket" do
    subject do
      aws_s3_bucket(bucket_name: aws_bucket_private_name).bucket_acl.select do |g|
        g.grantee.type == 'Group' && g.grantee.uri =~ /AllUsers/
      end
    end
    it { should be_empty }
  end

  describe "Bucket ACL: AuthUser grants on a private bucket" do
    subject do
      aws_s3_bucket(bucket_name: aws_bucket_private_name).bucket_acl.select do |g|
        g.grantee.type == 'Group' && g.grantee.uri =~ /AuthenticatedUsers/
      end
    end
    it { should be_empty }
  end

  describe "Bucket ACL: AuthUser grants on an AuthUser bucket" do
    subject do
      aws_s3_bucket(bucket_name: aws_bucket_auth_name).bucket_acl.select do |g|
        g.grantee.type == 'Group' && g.grantee.uri =~ /AuthenticatedUsers/
      end
    end
    it { should_not be_empty }
  end

  #------------------- bucket_policy -------------------#
  describe "Bucket Policy: Allow GetObject Statement For Everyone on public" do
    subject do
      bucket_policy = aws_s3_bucket(bucket_name: aws_bucket_public_name).bucket_policy
      allow_all = bucket_policy.select { |s| s.effect == 'Allow' && s.principal == '*' }
      allow_all.count
    end
    it { should == 1 }
  end

  describe "Bucket Policy: Allow GetObject Statement For Everyone on private" do
    subject do
      bucket_policy = aws_s3_bucket(bucket_name: aws_bucket_private_name).bucket_policy
      allow_all = bucket_policy.select { |s| s.effect == 'Allow' && s.principal == '*' }
      allow_all.count
    end
    it { should be_zero }
  end

  describe "Bucket Policy: Empty policy on auth" do
    subject do
      aws_s3_bucket(bucket_name: aws_bucket_auth_name).bucket_policy
    end
    it { should be_empty }
  end
end
