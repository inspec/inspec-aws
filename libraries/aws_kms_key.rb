# frozen_string_literal: true

require 'aws_backend'

class AwsKmsKey < AwsResourceBase
  name 'aws_kms_key'
  desc 'Verifies settings for an individual AWS KMS Key'
  example "
    describe aws_kms_key(key_id: 'arn:aws:kms:us-east-1::key/4321dcba-21io-23de-85he-ab0987654321') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    # SDK permits key_id to hold either an ID or an ARN
    opts = { key_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(require_any_of: %i(key_id alias))
    if opts[:alias] && !opts[:key_id]
      @alias = opts[:alias]
      opts[:key_id] = fetch_key_id
    end
    @display_name = opts[:key_id]

    catch_aws_errors do
      begin
        resp = @aws.kms_client.describe_key({ key_id: opts[:key_id] })
        @key = resp.key_metadata.to_h
        create_resource_methods(@key)
        @key_rotation_response = @aws.kms_client.get_key_rotation_status({ key_id: opts[:key_id] }) unless @key[:key_manager] == 'AWS'
      rescue Aws::KMS::Errors::NotFoundException
        @key = {}
        return
      end
    end
  end

  def exists?
    !@key.empty?
  end

  def created_days_ago
    ((Time.now - @key[:creation_date]) / (24 * 60 * 60)).to_i unless @key[:creation_date].nil?
  end

  def deletion_time
    @key[:deletion_date]
  end

  def invalidation_time
    @key[:valid_to]
  end

  def external?
    @key[:origin] == 'EXTERNAL'
  end

  def enabled?
    @key[:enabled]
  end

  def managed_by_aws?
    @key[:key_manager] == 'AWS'
  end

  def has_key_expiration?
    @key[:expiration_model] == 'KEY_MATERIAL_EXPIRES'
  end

  def has_rotation_enabled?
    @key_rotation_response.key_rotation_enabled unless @key_rotation_response.nil? || @key_rotation_response.empty?
  end

  def to_s
    opts.key?(:aws_region) ? "KMS Key #{@display_name} in #{opts[:aws_region]}" : "KMS Key #{@display_name}"
  end

  def fetch_key_id
    catch_aws_errors do
      response = @aws.kms_client.list_aliases
      if response || !response.empty?
        response.aliases.each do |alias_entry|
          if alias_entry['alias_name'] == @alias && alias_entry['target_key_id']
            return alias_entry['target_key_id']
          end
        end
      end
      fail_resource("Unable to find KMS Key using provided alias: #{@alias}")
    end
  end
end
