# frozen_string_literal: true

require 'aws_backend'

class AWSS3BucketPolicy < AwsResourceBase
  name 'aws_s3_bucket_policy'
  desc 'Retrieves information about a bucket policy.'

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
      parsed_json = JSON.parse(resp.policy.read)
      @version = !parsed_json['Version'].nil? && parsed_json['Version']
      @id = !parsed_json['Id'].nil? && parsed_json['Id']
      @effect = !parsed_json['Effect'].nil? && parsed_json['Effect']
      @principal = !parsed_json['Principal'].nil? && parsed_json['Principal']
      @action = !parsed_json['Action'].nil? && parsed_json['Action']
      @resource = !parsed_json['Resource'].nil? && parsed_json['Resource']
      require 'byebug'
      byebug
    end
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "S3 Bucket Name: #{@display_name}"
  end
end
