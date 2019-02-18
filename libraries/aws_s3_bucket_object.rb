# frozen_string_literal: true

require 'aws_backend'

class AwsS3BucketObject < AwsResourceBase
  name 'aws_s3_bucket_object'
  desc 'Verifies settings for a s3 bucket object'
  example "
    describe aws_s3_bucket_object(bucket_name: 'bucket_name', key: 'file_name') do
      it { should exist }
      it { should_not be_public }
    end
  "
  attr_reader :bucket_name, :key

  def initialize(opts = {})
    # Call the parent class constructor
    super(opts)
    validate_parameters(%i(bucket_name key))
    raise ArgumentError, 'aws_s3_bucket_object - Both bucket_name and key are required' if opts.empty? or !opts.key?(:bucket_name) or !opts.key?(:key)
    @bucket_name = opts[:bucket_name]
    @key = opts[:key]
    catch_aws_errors do
      begin
        @bucket_object = @aws.storage_client.get_object(bucket: @bucket_name, key: @key)
      rescue Aws::S3::Errors::NoSuchBucket
        @exists = false
        return
      rescue Aws::S3::Errors::NoSuchKey
        @exists = false
        return
      end
    end
    @exists = true
  end

  def object_acl
    return @object_acl if defined? @object_acl
    catch_aws_errors do
      @object_acl = @aws.storage_client.get_object_acl(bucket: @bucket_name, key: @key).grants
    end
    @object_acl
  end

  # RSpec will alias this to be_public
  def public?
    # first line just for formatting
    false || \
      object_acl.any? { |g| g.grantee.type == 'Group' && g.grantee.uri =~ /AllUsers/ } || \
      object_acl.any? { |g| g.grantee.type == 'Group' && g.grantee.uri =~ /AuthenticatedUsers/ }
  end

  def exists?
    @exists
  end

  def to_s
    "s3://#{@bucket_name}/#{@key}"
  end
end
