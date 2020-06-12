require 'helper'
require 'aws_s3_bucket'
require 'aws-sdk-core'

class AwsS3BucketConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsS3Bucket.new(client_args: { stub_responses: true }) }
  end

  def test_constructor_accept_param_hash
    AwsS3Bucket.new(bucket_name: 'some-bucket', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsS3Bucket.new(rubbish: 9) }
  end

  def test_bucket_non_existing
    not_existing = {}
    not_existing[:method] = :get_bucket_location
    not_existing[:data] = Aws::S3::Errors::NoSuchBucket.new(nil, nil)
    not_existing[:client] = Aws::S3::Client
    refute AwsS3Bucket.new(bucket_name: 'bucket-not-there', client_args: { stub_responses: true }, stub_data: [not_existing]).exists?
  end
end

class AwsS3BucketPublicTest < Minitest::Test

  def setup
    bucket_stub_data = []
    location = {}
    location[:method] = :get_bucket_location
    location[:data] = OpenStruct.new(location_constraint: 'eu-west-2')
    location[:client] = Aws::S3::Client
    bucket_stub_data += [location]
    acl = {}
    acl[:method] = :get_bucket_acl
    acl[:data] = OpenStruct.new(
        :grants => [
            OpenStruct.new(grantee: OpenStruct.new(type: 'CanonicalUser'), permission: 'FULL_CONTROL',),
            OpenStruct.new(grantee: OpenStruct.new(type: 'Group', uri: 'http://acs.amazonaws.com/groups/global/AllUsers'), permission: 'READ'),
        ])
    acl[:client] = Aws::S3::Client
    bucket_stub_data += [acl]
    policy_status = {}
    policy_status[:method] = :get_bucket_policy_status
    policy_status[:data] = OpenStruct.new(policy_status: OpenStruct.new(is_public: true))
    policy_status[:client] = Aws::S3::Client
    bucket_stub_data += [policy_status]
    encrypted = {}
    encrypted[:method] = :get_bucket_encryption
    encrypted[:data] = OpenStruct.new(server_side_encryption_configuration: 'aws:kms')
    encrypted[:client] = Aws::S3::Client
    bucket_stub_data += [encrypted]
    logging = {}
    logging[:method] = :get_bucket_logging
    logging[:data] = OpenStruct.new(logging_enabled: OpenStruct.new(target_bucket: 'targetbucket'))
    logging[:client] = Aws::S3::Client
    bucket_stub_data += [logging]
    versioning = {}
    versioning[:method] = :get_bucket_versioning
    versioning[:data] = OpenStruct.new(status: 'Enabled', mfa_delete: 'Disabled')
    versioning[:client] = Aws::S3::Client
    bucket_stub_data += [versioning]
    policy = {}
    policy[:method] = :get_bucket_policy
    policy[:data] = OpenStruct.new(policy: StringIO.new(<<'EOP')
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::bucket-12345/*"
    },
    {
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:*",
        "Resource": "arn:aws:s3:::bucket-12345/*",
        "Condition": {
            "Bool": {
                "aws:SecureTransport": "false"
            }
        }
    }
  ]
}
EOP
    )
    policy[:client] = Aws::S3::Client
    bucket_stub_data += [policy]
    @bucket = AwsS3Bucket.new(bucket_name: 'bucket-12345', client_args: { stub_responses: true }, stub_data: bucket_stub_data)
  end

  def test_bucket_exists
    assert @bucket.exists?
  end

  def test_bucket_region
    assert_equal(@bucket.region, 'eu-west-2')
  end

  def test_bucket_name
    assert_equal(@bucket.bucket_name, 'bucket-12345')
  end

  def test_bucket_public
    assert(@bucket.public?)
  end

  def test_has_access_logging_enabled_positive
    assert(@bucket.has_access_logging_enabled?)
  end

  def test_has_default_encryption_enabled_positive
    assert(@bucket.has_default_encryption_enabled?)
  end

  def test_has_versioning_enabled_positive
    assert(@bucket.has_versioning_enabled?)
  end

  def test_property_bucket_acl_structure
    assert_kind_of(Array, @bucket.bucket_acl)
    assert(@bucket.bucket_acl.size > 0)
    assert(@bucket.bucket_acl.all? { |g| g.respond_to?(:permission) })
    assert(@bucket.bucket_acl.all? { |g| g.respond_to?(:grantee) })
    assert(@bucket.bucket_acl.all? { |g| g.grantee.respond_to?(:type) })
  end

  def test_property_bucket_acl_public
    public_grants = @bucket.bucket_acl.select do |g|
      g.grantee.type == 'Group' && g.grantee.uri =~ /AllUsers/
    end
    refute_empty(public_grants)
  end

  def test_property_bucket_policy_structure
    assert_kind_of(Array, @bucket.bucket_policy)
    assert_kind_of(OpenStruct, @bucket.bucket_policy.first)
    [:effect, :principal, :action, :resource].each do |field|
      assert_respond_to(@bucket.bucket_policy.first, field)
    end
  end

  def test_property_bucket_policy_public
    allow_all = @bucket.bucket_policy.select { |s| s.effect == 'Allow' && s.principal == '*' }
    assert_equal(1, allow_all.count)
  end

  def test_has_default_encryption_enabled_positive
    assert(@bucket.has_secure_transport_enabled?)
  end

  def test_bucket_lifecycle_rules
    assert_equal([], @bucket.bucket_lifecycle_rules)
  end
end

class AwsS3BucketPrivateTest < Minitest::Test

  def setup
    bucket_stub_data = []
    location = {}
    location[:method] = :get_bucket_location
    location[:data] = OpenStruct.new(location_constraint: 'eu-west-2')
    location[:client] = Aws::S3::Client
    bucket_stub_data += [location]
    acl = {}
    acl[:method] = :get_bucket_acl
    acl[:data] = OpenStruct.new(
        :grants => [
            OpenStruct.new(grantee: OpenStruct.new(type: 'CanonicalUser'), permission: 'FULL_CONTROL',),
        ])
    acl[:client] = Aws::S3::Client
    bucket_stub_data += [acl]
    policy_status = {}
    policy_status[:method] = :get_bucket_policy_status
    policy_status[:data] = OpenStruct.new(policy_status: OpenStruct.new(is_public: false))
    policy_status[:client] = Aws::S3::Client
    bucket_stub_data += [policy_status]
    encrypted = {}
    encrypted[:method] = :get_bucket_encryption
    encrypted[:data] = OpenStruct.new(server_side_encryption_configuration: nil)
    encrypted[:client] = Aws::S3::Client
    bucket_stub_data += [encrypted]
    logging = {}
    logging[:method] = :get_bucket_logging
    logging[:data] = OpenStruct.new(logging_enabled: nil)
    logging[:client] = Aws::S3::Client
    bucket_stub_data += [logging]
    policy = {}
    policy[:method] = :get_bucket_policy
    policy[:data] = OpenStruct.new(policy: StringIO.new(<<'EOP')
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyGetObject",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::private/*"
    }
  ]
}
EOP
    )
    policy[:client] = Aws::S3::Client
    bucket_stub_data += [policy]
    lifecycle_configuration = {}
    lifecycle_configuration[:method] = :get_bucket_lifecycle_configuration
    lifecycle_configuration[:data] = OpenStruct.new(rules: [
                                                      OpenStruct.new(
                                                        expiration: OpenStruct.new(date: nil, days: 365, expired_object_delete_marker: nil),
                                                        id: 'expire rule',
                                                        prefix: nil,
                                                        filter: OpenStruct.new(prefix: '', tag: nil, and: nil),
                                                        status: 'Enabled',
                                                        transition: [],
                                                        noncurrent_version_transitions: [],
                                                        noncurrent_version_expiration: OpenStruct.new(noncurrent_days: 365),
                                                        abort_incomplete_multipart_upload: nil,
                                                      ),
                                                    ])
    lifecycle_configuration[:client] = Aws::S3::Client
    bucket_stub_data += [lifecycle_configuration]
    @bucket = AwsS3Bucket.new(bucket_name: 'private', client_args: { stub_responses: true }, stub_data: bucket_stub_data)
  end

  def test_bucket_exists
    assert @bucket.exists?
  end

  def test_bucket_region
    assert_equal(@bucket.region, 'eu-west-2')
  end

  def test_bucket_name
    assert_equal(@bucket.bucket_name, 'private')
  end

  def test_bucket_public
    refute(@bucket.public?)
  end

  def test_has_access_logging_enabled_positive
    refute(@bucket.has_access_logging_enabled?)
  end

  def test_has_default_encryption_enabled_positive
    refute(@bucket.has_default_encryption_enabled?)
  end

  def test_property_bucket_acl_structure
    assert_kind_of(Array, @bucket.bucket_acl)
    assert(@bucket.bucket_acl.size > 0)
    assert(@bucket.bucket_acl.all? { |g| g.respond_to?(:permission) })
    assert(@bucket.bucket_acl.all? { |g| g.respond_to?(:grantee) })
    assert(@bucket.bucket_acl.all? { |g| g.grantee.respond_to?(:type) })
  end

  def test_property_bucket_acl_private
    public_grants = @bucket.bucket_acl.select do |g|
      g.grantee.type == 'Group' && g.grantee.uri =~ /AllUsers/
    end
    assert_empty(public_grants)

    auth_users_grants = @bucket.bucket_acl.select do |g|
      g.grantee.type == 'Group' && g.grantee.uri =~ /AuthenticatedUsers/
    end
    assert_empty(auth_users_grants)
  end

  def test_property_bucket_policy_private
    allow_all = @bucket.bucket_policy.select { |s| s.effect == 'Allow' && s.principal == '*' }
    assert_equal(0, allow_all.count)
  end

  def test_has_default_encryption_enabled_positive
    refute(@bucket.has_secure_transport_enabled?)
  end

  def test_bucket_lifecycle_rules
    assert_equal(365, @bucket.bucket_lifecycle_rules.first.expiration.days)
  end
end

class AwsS3BucketAuthUsersTest < Minitest::Test

  def setup
    bucket_stub_data = []
    location = {}
    location[:method] = :get_bucket_location
    location[:data] = OpenStruct.new(location_constraint: 'eu-west-2')
    location[:client] = Aws::S3::Client
    bucket_stub_data += [location]
    acl = {}
    acl[:method] = :get_bucket_acl
    acl[:data] = OpenStruct.new(
        :grants => [
            OpenStruct.new(grantee: OpenStruct.new(type: 'CanonicalUser'), permission: 'FULL_CONTROL',),
            OpenStruct.new(
                grantee: OpenStruct.new(
                    type: 'Group',
                    uri: 'http://acs.amazonaws.com/groups/global/AuthenticatedUsers'
                ),
                permission: 'READ',
                ),
        ])
    acl[:client] = Aws::S3::Client
    bucket_stub_data += [acl]
    policy = {}
    policy[:method] = :get_bucket_policy
    policy[:data] = nil
    policy[:client] = Aws::S3::Client
    bucket_stub_data += [policy]
    @bucket = AwsS3Bucket.new(bucket_name: 'auth_users', client_args: { stub_responses: true }, stub_data: bucket_stub_data)
  end

  def test_bucket_exists
    assert @bucket.exists?
  end

  def test_property_bucket_acl_auth_users
    public_grants = @bucket.bucket_acl.select do |g|
      g.grantee.type == 'Group' && g.grantee.uri =~ /AllUsers/
    end
    assert_empty(public_grants)

    auth_users_grants = @bucket.bucket_acl.select do |g|
      g.grantee.type == 'Group' && g.grantee.uri =~ /AuthenticatedUsers/
    end
    refute_empty(auth_users_grants)
  end

  def test_property_bucket_policy_auth
    assert_empty(@bucket.bucket_policy)
  end

end
