# frozen_string_literal: true

require 'aws_backend'

class AWSS3AccessPoint < AwsResourceBase
  name 'aws_s3_access_point'
  desc 'Describes one S3 Access Points.'

  example "
    describe aws_s3_access_point(bucket_name: 'BucketName', id: 'MetricsId') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { bucket_name: opts } if opts.is_a?(String)
    opts = { id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(bucket_name id))
    raise ArgumentError, "#{@__resource_name__}: bucket_name must be provided" unless opts[:bucket_name] && !opts[:bucket_name].empty?
    raise ArgumentError, "#{@__resource_name__}: id must be provided" unless opts[:id] && !opts[:id].empty?
    @display_name = opts[:bucket]
    catch_aws_errors do
      resp = @aws.s3.get_bucket_metrics_configuration({ bucket: opts[:bucket_name], id: opts[:id] })
      @resp = resp.metrics_configuration.filter.to_h
      create_resource_methods(@resp)
    end
  end

  def bucket_name
    return nil unless exists?
    @resp[:bucket]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "Bucket Name: #{@display_name}"
  end
end
