# frozen_string_literal: true

require 'aws_backend'

class AWSS3BucketPolicy < AwsResourceBase
  name 'aws_s3_bucket_policy'
  desc 'Retrieves the policy of a specified S3 Bucket.'

  example "
    describe aws_s3_bucket_policy(bucket: 'BUCKET_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(bucket))
    raise ArgumentError, "#{@__resource_name__}: bucket must be provided" unless opts[:bucket] && !opts[:bucket].empty?
    @display_name = opts[:bucket]
    catch_aws_errors do
      resp = @aws.storage_client.get_bucket_policy({ bucket: opts[:bucket] })
      @parsed_json = JSON.parse(resp.policy.read)['Statement']
      create_resource_methods(@parsed_json[0])
    end
  end

  def exists?
    !@parsed_json.nil? && !@parsed_json.empty?
  end

  def resource_id
    @display_name
  end

  def to_s
    "S3 Bucket Policy of #{@display_name}"
  end
end
