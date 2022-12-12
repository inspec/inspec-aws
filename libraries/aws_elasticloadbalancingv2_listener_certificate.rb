require "aws_backend"

class AWSElasticLoadBalancingV2ListenerCertificate < AwsResourceBase
  name "aws_elasticloadbalancingv2_listener_certificate"
  desc "Describes the default certificate and the certificate list for the specified HTTPS or TLS listener"

  example "
    describe aws_elasticloadbalancingv2_listener_certificate(listener_arn: 'test') do
      it { should exist }
    end
  "
  def initialize(opts = {})
    opts = { listener_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:listener_arn])
    raise ArgumentError, "#{@__resource_name__}: listener_arn must be provided" unless opts[:listener_arn] && !opts[:listener_arn].empty?
    @display_name = opts[:listener_arn]
    catch_aws_errors do
      resp = @aws.elb_client_v2.describe_listener_certificates({ listener_arn: opts[:listener_arn] })
      @listeners = resp.certificates[0].to_h
      create_resource_methods(@listeners)
    end
  end

  def listener_arn
    return nil unless exists?
    @listeners[:listener_arn]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@listeners.nil? && !@listeners.empty?
  end

  def to_s
    "Listener ARN: #{@display_name}"
  end
end
