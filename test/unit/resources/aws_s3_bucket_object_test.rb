require 'helper'
require 'aws_s3_bucket_object'
require 'aws-sdk-core'

class AwsS3BucketObjectConstructorTest < Minitest::Test

  def test_constructor_no_args_raises
    assert_raises(ArgumentError) { AwsS3BucketObject.new }
  end

  def test_constructor_no_bucket_name_arg_raises
    assert_raises(ArgumentError) { AwsS3BucketObject.new(:key, 'key') }
  end

  def test_constructor_no_key_arg_raises
    assert_raises(ArgumentError) { AwsS3BucketObject.new(:bucket_name, 'bucket') }
  end

  def test_constructor_expected_well_formed_args
    AwsS3BucketObject.new(bucket_name: 'Public Bucket', key: 'public_file.jpg', client_args: { stub_responses: true })
  end

  def test_constructor_reject_unknown_resource_params
    assert_raises(ArgumentError) { AwsS3BucketObject.new(bla: 'NonExistingBucket') }
  end

  def test_constructor_reject_bucket_not_given
    assert_raises(ArgumentError) { AwsS3BucketObject.new(key: 'public_file.jpg') }
  end

  def test_constructor_reject_key_not_given
    assert_raises(ArgumentError) { AwsS3BucketObject.new(bucket_name: 'Public Bucket') }
  end

  def test_bucket_non_existing
    not_existing = {}
    not_existing[:method] = :get_object
    not_existing[:data] = Aws::S3::Errors::NoSuchBucket.new(nil, nil)
    not_existing[:client] = Aws::S3::Client
    refute AwsS3BucketObject.new(bucket_name: 'bucket-not-there', key: 'file.test', client_args: { stub_responses: true }, stub_data: [not_existing]).exists?
  end

  def test_bucket_key_non_existing
    not_existing = {}
    not_existing[:method] = :get_object
    not_existing[:data] = Aws::S3::Errors::NoSuchKey.new(nil, nil)
    not_existing[:client] = Aws::S3::Client
    refute AwsS3BucketObject.new(bucket_name: 'bucket-not-there', key: 'file.test', client_args: { stub_responses: true }, stub_data: [not_existing]).exists?
  end
end

class AwsS3BucketObjecPublicTest < Minitest::Test

  def setup
    # an empty response from get_object is sufficient in this case for the resource to exist
    # so only need to stub out getting the acl
    bucket_object = {}
    bucket_object[:method] = :get_object_acl
    bucket_object[:data] = OpenStruct.new({ :grants => [
        OpenStruct.new({ 'grantee' => OpenStruct.new({ type: 'CanonicalUser', }), permission: 'FULL_CONTROL', }),
        OpenStruct.new({ 'grantee' => OpenStruct.new({ type: 'AmazonCustomerByEmail' }), permission: 'READ', }),
        OpenStruct.new({ 'grantee' => OpenStruct.new({ type: 'Group', uri: 'http://acs.amazonaws.com/groups/global/AllUsers' }), permission: 'READ', }),
    ] })
    bucket_object[:client] = Aws::S3::Client
    @bucket_object = AwsS3BucketObject.new(bucket_name: 'public_bucket', key: 'public.file', client_args: { stub_responses: true }, stub_data: [bucket_object])
  end

  def test_bucket_object_exists
    assert @bucket_object.exists?
  end

  def test_bucket_object_bucket_name
    assert_equal(@bucket_object.bucket_name, 'public_bucket')
  end

  def test_bucket_object_key
    assert_equal(@bucket_object.key, 'public.file')
  end

  def test_bucket_object_public
    assert(@bucket_object.public?)
  end

  def test_bucket_object_string
    assert_equal(@bucket_object.to_s, 's3://public_bucket/public.file')
  end

  def test_property_object_acl_structure
    assert_kind_of(Array, @bucket_object.object_acl)
    assert(@bucket_object.object_acl.size > 0)
    assert(@bucket_object.object_acl.all? { |g| g.respond_to?(:permission) })
    assert(@bucket_object.object_acl.all? { |g| g.respond_to?(:grantee) })
    assert(@bucket_object.object_acl.all? { |g| g.grantee.respond_to?(:type) })
  end

  def test_property_object_acl_public
    public_grants = @bucket_object.object_acl.select do |g|
      g.grantee.type == 'Group' && g.grantee.uri =~ /AllUsers/
    end
    refute_empty(public_grants)
  end
end

class AwsS3BucketObjecPrivateTest < Minitest::Test

  def setup
    # an empty response from get_object is sufficient in this case for the resource to exist
    # so only need to stub out getting the acl
    bucket_object = {}
    bucket_object[:method] = :get_object_acl
    bucket_object[:data] = OpenStruct.new({ :grants => [OpenStruct.new({ 'grantee' => OpenStruct.new({ type: 'CanonicalUser', }), permission: 'FULL_CONTROL', }),] })
    bucket_object[:client] = Aws::S3::Client
    @bucket_object = AwsS3BucketObject.new(bucket_name: 'private_bucket', key: 'private.file', client_args: { stub_responses: true }, stub_data: [bucket_object])
  end

  def test_bucket_object_exists
    assert @bucket_object.exists?
  end

  def test_bucket_object_bucket_name
    assert_equal(@bucket_object.bucket_name, 'private_bucket')
  end

  def test_bucket_object_key
    assert_equal(@bucket_object.key, 'private.file')
  end

  def test_bucket_object_public
    refute(@bucket_object.public?)
  end

  def test_bucket_object_string
    assert_equal(@bucket_object.to_s, 's3://private_bucket/private.file')
  end

  def test_property_object_acl_private
    public_grants = @bucket_object.object_acl.select do |g|
      g.grantee.type == 'Group' && g.grantee.uri =~ /AllUsers/
    end
    assert_empty(public_grants)

    auth_users_grants = @bucket_object.object_acl.select do |g|
      g.grantee.type == 'Group' && g.grantee.uri =~ /AuthenticatedUsers/
    end
    assert_empty(auth_users_grants)
  end
end