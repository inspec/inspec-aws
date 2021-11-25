# frozen_string_literal: true

require 'aws_backend'

class AWSRDSS3Policy < AwsResourceBase
  name 'aws_s3_bucket_policy'
  desc 'Retrieves information about a bucket policy.'

  example "
    describe aws_s3_bucket_policy(account_id: 'ACCOUNT_ID', bucket: 'BUCKET_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(account_id bucket))
    raise ArgumentError, "#{@__resource_name__}: account_id must be provided" unless opts[:account_id] && !opts[:account_id].empty?
    raise ArgumentError, "#{@__resource_name__}: bucket must be provided" unless opts[:bucket] && !opts[:bucket].empty?
    @display_name = opts[:bucket]
    catch_aws_errors do
      resp = @aws.s3control_client.get_bucket_policy({ account_id: opts[:account_id], bucket: opts[:bucket] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "S3 Bucket Name: #{@display_name}"
  end
end
