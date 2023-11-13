require 'aws_backend'

class AwsCloudFrontDistribution < AwsResourceBase
  name 'aws_cloudfront_distribution'
  desc 'Verifies settings for a CloudFront Distribution.'
  example <<-EXAMPLE
    describe aws_cloudfront_distribution('CLOUDFRONT_DISTRIBUTION_ID') do
      it { should exist }
    end
  EXAMPLE

  attr_reader :distribution_id, :viewer_certificate_minimum_ssl_protocol, :viewer_protocol_policies,
              :custom_origin_ssl_protocols, :s3_origin_configs, :custom_origin_protocol_policies, :s3_origin_path, :s3_origin_access, :ssl_certificate,
              :access_logging

  def initialize(opts = {})
    opts = { distribution_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:distribution_id], allow: %i(disallowed_ssl_protocols origin_domain_name))

    @distribution_id = opts[:distribution_id]
    if opts[:disallowed_ssl_protocols]
      @disallowed_ssl_protocols = opts[:disallowed_ssl_protocols]
      if @disallowed_ssl_protocols.is_a?(String)
        @disallowed_ssl_protocols = [@disallowed_ssl_protocols]
      end
    else
      @disallowed_ssl_protocols = %w{SSLv3 TLSv1 TLSv1_2016}
    end

    catch_aws_errors do
      @resp = @aws.cloudfront_client.get_distribution(id: opts[:distribution_id])
    end
    return if @resp.nil?

    @distribution_arn = @resp.distribution.arn
    config = @resp.distribution.distribution_config

    @access_logging = config.logging

    @ssl_certificate = config.viewer_certificate.certificate_source

    # AWS CloudFront web distribution that allow TLS versions 1.0 or lower
    # AWS CloudFront distribution is using insecure SSL protocols for HTTPS communication

    # The Viewer Certificate minimum SSL version at the time of writing is TLSv1 for a default cloud certificate,
    # and for custom certifcates one of TLSv1.2_2021, TLSv1.2_2019, TLSv1.2_2018, TLSv1.1_2016, TLSv1_2016 or TLSv1
    @viewer_certificate_minimum_ssl_protocol = config.viewer_certificate[:minimum_protocol_version]

    # Each distribution has a default cache behavior viewer protocol policy, and zero or more additional cache
    # behavior viewer protocol policies, for different origins.
    # A viewer protocol policy is one of "https-only", "redirect-to-https" or "allow-all".
    @viewer_protocol_policies = [config.default_cache_behavior.viewer_protocol_policy]

    # If there are additional cache behaviors, add them to the list
    if config.cache_behaviors.quantity > 0
      config.cache_behaviors.items.each do |behavior|
        @viewer_protocol_policies << behavior[:viewer_protocol_policy]
      end
      @viewer_protocol_policies = @viewer_protocol_policies.uniq.sort
    end

    @custom_origin_protocol_policies = []
    @custom_origin_ssl_protocols = []
    @s3_origin_access = []
    @s3_origin_configs = false
    config.origins.items.each do |origin|
      if origin[:s3_origin_config]
        @s3_origin_configs = true
        @s3_origin_access << origin[:s3_origin_config][:origin_access_identity]
      elsif origin[:custom_origin_config]
        @custom_origin_ssl_protocols += origin[:custom_origin_config][:origin_ssl_protocols][:items]
        @custom_origin_protocol_policies += [origin[:custom_origin_config][:origin_protocol_policy]]
      end
    end
    @custom_origin_ssl_protocols = @custom_origin_ssl_protocols.uniq.sort
    @custom_origin_protocol_policies = @custom_origin_protocol_policies.uniq.sort
    @s3_origin_access = @s3_origin_access.uniq.sort

    # Find aws cloudfront distribution origin path.
    # Either return path string, or ""
    return unless opts[:origin_domain_name]
    config.origins.items.each do |origin_config|
      if origin_config.domain_name == opts[:origin_domain_name]
        @s3_origin_path = origin_config.origin_path
      end
    end
  end

  def resource_id
    @resp? @resp[:distribution][:id]: @distribution_id
  end

  def exists?
    !@distribution_arn.nil? && @distribution_arn.start_with?('arn')
  end

  def has_access_logging_enabled?
    @access_logging.enabled
  end

  def has_viewer_protocol_policies_allowing_http?
    @viewer_protocol_policies.include? 'allow-all'
  end

  def has_disallowed_viewer_certificate_minimum_ssl_protocol?
    disallowed?([@viewer_certificate_minimum_ssl_protocol])
  end

  def has_s3_origin_configs?
    @s3_origin_configs
  end

  def has_disallowed_custom_origin_ssl_protocols?
    disallowed?(@custom_origin_ssl_protocols)
  end

  def to_s
    "AWS CloudFront Distribution #{@distribution_id}"
  end

  private

  def disallowed?(ssl_protocols)
    ssl_protocols.any? { |p| @disallowed_ssl_protocols.include? p }
  end
end
