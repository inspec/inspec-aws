require "aws_backend"

class AwsKmsKey < AwsResourceBase
  name "aws_kms_key"
  desc "Verifies settings for an individual AWS KMS Key."
  example "
    describe aws_kms_key(key_id: 'arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      it { should exist }
    end
  "

  attr_reader :display_name, :arn, :alias

  def initialize(opts = {})
    # SDK permits key_id to hold either an ID or an ARN
    opts = { key_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(require_any_of: %i(key_id alias))
    if opts[:alias] && !opts[:key_id]
      @alias = opts[:alias]
      opts[:key_id] = fetch_key_id
    end
    @display_name = key_metadata[:key_id]
    @arn = key_metadata[:arn]

    create_resource_methods(key_metadata)
  end

  def resource_id
    @arn
  end

  def exists?
    !key_metadata.blank?
  end

  def kms_tags(tag_list)
    return {} if tag_list.nil? || tag_list.empty?
    tags = {}
    tag_list.each do |tag|
      tags[tag[:tag_key]] = tag[:tag_value]
    end
    tags
  end

  def tags
    tag_list = catch_aws_errors do
      kms_client.list_resource_tags(key_id: opts[:key_id]).tags
    end
    kms_tags(tag_list)
  end

  def created_days_ago
    return unless key_metadata[:creation_date]

    ((Time.now - key_metadata[:creation_date]) / (24 * 60 * 60)).to_i
  end

  def deletion_time
    key_metadata[:deletion_date]
  end

  def invalidation_time
    key_metadata[:valid_to]
  end

  def external?
    key_metadata[:origin] == "EXTERNAL"
  end

  def enabled?
    key_metadata[:enabled]
  end

  def managed_by_aws?
    key_metadata[:key_manager] == "AWS"
  end

  def has_key_expiration?
    key_metadata[:expiration_model] == "KEY_MATERIAL_EXPIRES"
  end

  def has_rotation_enabled?
    key_rotation_response.key_rotation_enabled unless key_rotation_response.blank?
  end

  def to_s
    opts.key?(:aws_region) ? "KMS Key #{@display_name} in #{opts[:aws_region]}" : "KMS Key #{@display_name}"
  end

  def fetch_key_id
    response = catch_aws_errors do
      kms_client.list_aliases
    end
    if response.present?
      response.aliases.each do |alias_entry|
        if alias_entry["alias_name"] == @alias && alias_entry["target_key_id"]
          return alias_entry["target_key_id"]
        end
      end
    end
    fail_resource("Unable to find KMS Key using provided alias: #{@alias}")
  end

  private

  def key_metadata
    @key_metadata ||= catch_aws_errors do
      kms_client.describe_key({ key_id: opts[:key_id] }).key_metadata.to_h
    rescue Aws::KMS::Errors::NotFoundException
      {}
    end
  end

  def key_rotation_response
    return if key_metadata[:key_manager] == "AWS"
    @key_rotation_response ||= catch_aws_errors do
      kms_client.get_key_rotation_status({ key_id: opts[:key_id] })
    end
  end

  def kms_client
    @aws.kms_client
  end
end
