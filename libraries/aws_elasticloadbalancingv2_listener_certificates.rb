require 'aws_backend'

class AWSElasticLoadBalancingV2ListenerCertificates < AwsResourceBase
  name 'aws_elasticloadbalancingv2_listener_certificates'
  desc 'Describes the default certificate and the certificate list for the specified HTTPS or TLS listener'

  example "
    describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'test1') do
      it { should exist }
    end

    describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: 'test1') do
      its('count') { should eq 3 }
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:certificate_arns,                      field: :certificate_arn)
             .register_column(:is_defaults,                           field: :is_default)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(listener_arn))
    @query_params = {}
    @query_params[:listener_arn] = opts[:listener_arn]
    if opts.key?(:listener_arn)
      raise ArgumentError, "#{@__resource_name__}: listener_arn must be provided" unless opts[:listener_arn] && !opts[:listener_arn].empty?
      @query_params[:listener_arn] = opts[:listener_arn]
    end
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.elb_client_v2.describe_listener_certificates(@query_params)
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.certificates.map(&:to_h)
  end
end
