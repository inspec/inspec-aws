# frozen_string_literal: true

require 'aws_backend'

class AwsS3Bucket < AwsResourceBase
  name 'aws_s3_bucket'
  desc 'Verifies settings for a s3 bucket'
  example "
    describe aws_s3_bucket(bucket_name: 'test_bucket') do
      it { should exist }
    end
  "

  attr_reader :region, :bucket_name

  def initialize(opts = {})
    # Call the parent class constructor
    opts = { bucket_name: opts } if opts.is_a?(String) # this preserves the original scalar interface
    super(opts)
    validate_parameters([:bucket_name])
    @bucket_name = opts[:bucket_name]

    catch_aws_errors do
      begin
        @region = @aws.storage_client.get_bucket_location(bucket: @bucket_name).location_constraint
      rescue Aws::S3::Errors::NoSuchBucket
        @region = nil
      end
    end
  end

  def exists?
    !@region.nil?
  end

  def bucket_acl
    return [] unless exists? # exists? would throw the same NoSuchBucket error if the bucket name was not valid
    catch_aws_errors do
      @bucket_acl ||= @aws.storage_client.get_bucket_acl(bucket: @bucket_name).grants
    end
  end

  def public?
    return false unless exists?
    catch_aws_errors do
      begin
        @bucket_policy_status_public = @aws.storage_client.get_bucket_policy_status(bucket: @bucket_name).policy_status.is_public
      rescue Aws::S3::Errors::NoSuchBucketPolicy
        @bucket_policy_status_public = false # preserves the original behaviour
      end
      @bucket_policy_status_public || \
        bucket_acl.any? { |g| g.grantee.type == 'Group' && g.grantee.uri =~ /AllUsers/ } || \
        bucket_acl.any? { |g| g.grantee.type == 'Group' && g.grantee.uri =~ /AuthenticatedUsers/ }
    end
  end

  def has_access_logging_enabled?
    return false unless exists?
    catch_aws_errors do
      @has_access_logging_enabled ||= !@aws.storage_client.get_bucket_logging(bucket: @bucket_name).logging_enabled.nil?
    end
  end

  def has_default_encryption_enabled?
    return false unless exists?
    @has_default_encryption_enabled ||= catch_aws_errors do
      begin
        @has_default_encryption_enabled = !@aws.storage_client.get_bucket_encryption(bucket: @bucket_name).server_side_encryption_configuration.nil?
      rescue Aws::S3::Errors::ServerSideEncryptionConfigurationNotFoundError
        false
      end
    end
  end

  # below is to preserve the original 'unsupported' function but isn't used in the above
  def bucket_policy
    @bucket_policy ||=fetch_bucket_policy
  end

  def fetch_bucket_policy
    policy_list = []
    catch_aws_errors do
      begin
        # AWS SDK returns a StringIO, we have to read()
        raw_policy = @aws.storage_client.get_bucket_policy(bucket: @bucket_name).to_h
        return [] if !raw_policy.key?(:policy)
        JSON.parse(raw_policy[:policy].read)['Statement'].map do |statement|
          lowercase_hash = {}
          statement.each_key { |k| lowercase_hash[k.downcase] = statement[k] }
          policy_list += [OpenStruct.new(lowercase_hash)]
        end
      rescue Aws::S3::Errors::NoSuchBucketPolicy
        return []
      rescue Aws::S3::Errors::NoSuchBucket
        return []
      end
    end
    policy_list
  end

  def to_s
    "S3 Bucket #{@bucket_name}"
  end
end
