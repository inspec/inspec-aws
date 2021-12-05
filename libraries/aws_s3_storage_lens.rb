# frozen_string_literal: true

require 'aws_backend'

class AWSS3StorageLens < AwsResourceBase
  name 'aws_s3_storage_lens'
  desc 'Gets the Amazon S3 Storage Lens configuration.'

  example "
    describe aws_s3_storage_lens(config_id: 'CONFIG_ID', account_id: 'ACCOUNT_ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(config_id account_id))
    raise ArgumentError, "#{@__resource_name__}: config_id must be provided" unless opts[:config_id] && !opts[:config_id].empty?
    raise ArgumentError, "#{@__resource_name__}: account_id must be provided" unless opts[:account_id] && !opts[:account_id].empty?
    @display_name = opts[:config_id]
    catch_aws_errors do
      resp = @aws.s3control_client.get_storage_lens_configuration({ config_id: opts[:config_id], account_id: opts[:account_id] })
      @res = resp.storage_lens_configuration.to_h
      create_resource_methods(@res)
    end
  end

  def config_id
    return nil unless exists?
    @res[:config_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "S3 Storage Lens: #{@display_name}"
  end
end
