require "aws_backend"

class AWSCloudFrontOriginRequestPolicy < AwsResourceBase
  name "aws_cloudfront_origin_request_policy"
  desc "Describes an origin request policy."
  example <<-EXAMPLE
    describe aws_cloudfront_origin_request_policy(id: 'ID') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:id])
    raise ArgumentError, "#{@__resource_name__}: id must be provided" unless opts[:id] && !opts[:id].empty?
    @display_name = opts[:id]
    resp = @aws.cloudfront_client.get_origin_request_policy({ id: opts[:id] })
    @origin_request_policy = resp.origin_request_policy.to_h
    @origin_request_policy_id = @origin_request_policy[:id]
    create_resource_methods(@origin_request_policy)
  end

  def resource_id
    @origin_request_policy_id
  end

  def id
    return nil unless exists?
    @origin_request_policy_id
  end

  def exists?
    !@origin_request_policy.nil? && !@origin_request_policy.empty?
  end

  def to_s
    "Origin Request Policy ID: #{@display_name}"
  end
end
