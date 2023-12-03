require "aws_backend"
require "hashie/mash"

class AwsS3Bucket < AwsResourceBase
  name "aws_s3_bucket"
  desc "Verifies settings for a s3 bucket."
  example "
    describe aws_s3_bucket(bucket_name: 'test_bucket') do
      it { should exist }
    end
  "

  attr_reader :region, :bucket_name, :versioning, :public_access_account_config, :public_access_config

  def initialize(opts = {})
    opts = { bucket_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:bucket_name])

    @bucket_name = opts[:bucket_name]

    catch_aws_errors do
      begin
        @region = @aws.storage_client.get_bucket_location(bucket: @bucket_name).location_constraint
        # LocationConstraint "EU" correlates to the region "eu-west-1", but region "EU" does not exist as a "region", only a LocationConstraint
        # this currently is the only Location constraint that can have either of 2 values "EU" or "eu-west-1".  But only "eu-west-1" is a region
        @region = "eu-west-1" if @region == "EU"
        # Forcing bucket region for future bucket calls to avoid warnings about multiple unnecessary
        # redirects and signing attempts.
        opts[:aws_region] = @region.empty? ? "us-east-1" : @region
        super(opts)
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

  def bucket_ownership_controls
    return [] unless exists? # exists? would throw the same NoSuchBucket error if the bucket name was not valid
    catch_aws_errors do
      @bucket_ownership_controls ||= @aws.storage_client.get_bucket_ownership_controls(bucket: @bucket_name).ownership_controls.rules[0].object_ownership
    end
  end

  def public?
    return false unless exists?
    catch_aws_errors do
      begin
        @bucket_policy_status_public = @aws.storage_client.get_bucket_policy_status(bucket: @bucket_name).policy_status.is_public
      rescue Aws::S3::Errors::NoSuchBucketPolicy
        @bucket_policy_status_public = false # preserves the original behavior
      end
      @bucket_policy_status_public || \
        bucket_acl.any? { |g| g.grantee.type == "Group" && g.grantee.uri =~ /AllUsers/ } || \
        bucket_acl.any? { |g| g.grantee.type == "Group" && g.grantee.uri =~ /AuthenticatedUsers/ }
    end
  end

  def has_access_logging_enabled?
    return false unless exists?
    catch_aws_errors do
      @has_access_logging_enabled ||= !@aws.storage_client.get_bucket_logging(bucket: @bucket_name).logging_enabled.nil?
    end
  end

  def prevent_public_access?
    return false unless exists?
    @prevent_public_access ||= catch_aws_errors do
      begin
        @public_access_config = @aws.storage_client.get_public_access_block(bucket: @bucket_name).public_access_block_configuration
      # API throws an error if no public block access is configured
      rescue Aws::S3::Errors::NoSuchPublicAccessBlockConfiguration
        return @public_access_config = false
      end
      @public_access_config.all?
    end
  end

  def prevent_public_access_by_account?
    return false unless exists?
    @prevent_public_access_by_account ||= catch_aws_errors do
      begin
        @account_id = fetch_aws_account
        @public_access_account_config = @aws.storage_control_client.get_public_access_block(account_id: @account_id).public_access_block_configuration
      rescue Aws::S3::Errors::NoSuchPublicAccessBlockConfiguration
        return @public_access_account_config = false
      end
    @public_access_account_config.all?
    end
  end

  def has_default_encryption_enabled?
    return false unless exists?
    @has_default_encryption_enabled ||= catch_aws_errors do
      begin
        @has_default_encryption_enabled = !@aws.storage_client.get_bucket_encryption(bucket: @bucket_name).server_side_encryption_configuration.nil?
      rescue Aws::S3::Errors::ServerSideEncryptionConfigurationNotFoundError
        false
      rescue StandardError => e
        fail_resource("Unexpected error thrown: #{e}")
      end
    end
  end

  def has_versioning_enabled?
    return false unless exists?
    catch_aws_errors do
      @has_versioning_enabled = @aws.storage_client.get_bucket_versioning(bucket: @bucket_name).status == "Enabled"
    end
  end

  def versioning
    return [] unless exists? # exists? would throw the same NoSuchBucket error if the bucket name was not valid
    catch_aws_errors do
      @versioning ||= Hashie::Mash.new(@aws.storage_client.get_bucket_versioning(bucket: @bucket_name))
    end
  end

  def has_secure_transport_enabled?
    bucket_policy.any? { |s| s.effect == "Deny" && s.condition && s.condition["Bool"] && s.condition["Bool"]["aws:SecureTransport"] && s.condition["Bool"]["aws:SecureTransport"] == "false" }
  end

  # below is to preserve the original 'unsupported' function but isn't used in the above
  def bucket_policy
    @bucket_policy ||= fetch_bucket_policy
  end

  def fetch_bucket_policy
    policy_list = []
    catch_aws_errors do
      begin
        # AWS SDK returns a StringIO, we have to read()
        raw_policy = @aws.storage_client.get_bucket_policy(bucket: @bucket_name).to_h
        return [] if !raw_policy.key?(:policy)
        JSON.parse(raw_policy[:policy].read)["Statement"].map do |statement|
          lowercase_hash = {}
          statement.each_key { |k| lowercase_hash[k.downcase] = statement[k] }
          policy_list += [OpenStruct.new(lowercase_hash)]
        end
      rescue Aws::S3::Errors::NoSuchBucketPolicy, Aws::S3::Errors::NoSuchBucket
        return []
      end
    end
    policy_list
  end

  def bucket_lifecycle_rules
    rules_list = []
    catch_aws_errors do
      begin
        rules_list = @aws.storage_client.get_bucket_lifecycle_configuration(bucket: @bucket_name).rules
      rescue Aws::S3::Errors::NoSuchLifecycleConfiguration
        return []
      end
    end
    rules_list
  end

  def tags
    begin
      tag_list = @aws.storage_client.get_bucket_tagging(bucket: @bucket_name).tag_set
    rescue
      return {}
    end
    map_tags(tag_list)
  end

  def resource_id
    @bucket_name
  end

  def to_s
    "S3 Bucket #{@bucket_name}"
  end
  
  private

  def fetch_aws_account
    arn = @aws.sts_client.get_caller_identity({}).arn
    arn.split(':')[4]
  end
end
