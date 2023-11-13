require "aws_backend"

class AWSS3AccessPoint < AwsResourceBase
  name "aws_s3_access_point"
  desc "Describes one S3 Access Points."

  example "
    describe aws_s3_access_point(bucket_name: 'BucketName', metrics_id: 'MetricsId') do
      it { should exits }
    end
  "

  def initialize(opts = {})
    opts = { bucket_name: opts } if opts.is_a?(String)
    opts = { metrics_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(bucket_name metrics_id))
    raise ArgumentError, "#{@__resource_name__}: bucket_name must be provided" unless opts[:bucket_name] && !opts[:bucket_name].empty?
    raise ArgumentError, "#{@__resource_name__}: metrics_id must be provided" unless opts[:metrics_id] && !opts[:metrics_id].empty?
    @display_name = opts[:metrics_id]
    catch_aws_errors do
      resp = @aws.storage_client.get_bucket_metrics_configuration({ bucket: opts[:bucket_name], id: opts[:metrics_id] })
      @resp = resp.metrics_configuration.to_h
      create_resource_methods(@resp)
    end
  end

  def metrics_id
    return unless exists?
    @resp[:id]
  end

  def exists?
    !@resp.nil? && !@resp.empty?
  end

  def to_s
    "Metrics ID: #{@display_name}"
  end
end
