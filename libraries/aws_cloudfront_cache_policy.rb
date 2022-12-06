require 'aws_backend'

class AWSCloudFrontCachePolicy < AwsResourceBase
  name 'aws_cloudfront_cache_policy'
  desc 'Gets a cache policy.'

  example "
    describe aws_cloudfront_cache_policy(id: 'ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(id))
    raise ArgumentError, "#{@__resource_name__}: id must be provided" unless opts[:id] && !opts[:id].empty?
    @display_name = opts[:id]
    catch_aws_errors do
      resp = @aws.cloudfront_client.get_cache_policy({ id: opts[:id] })
      @res = resp.cache_policy.to_h
      create_resource_methods(@res)
    end
  end

  def resource_id
    @res? @res[:id]: @display_name
  end

  def id
    return nil unless exists?
    @res[:id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "ID: #{@display_name}"
  end
end
