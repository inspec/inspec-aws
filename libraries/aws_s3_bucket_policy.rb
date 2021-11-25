# frozen_string_literal: true

require 'aws_backend'

class AWSRDSS3Policy < AwsResourceBase
  name 'aws_s3_bucket_policy'
  desc 'Retrieves information about a bucket policy'

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
      resp = @aws.s3_client.get_bucket_policy({ bucket: opts[:bucket] })
      @res = resp.policy
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
