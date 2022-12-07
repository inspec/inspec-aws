require 'aws_backend'

class AWSCloudwatchDashboard < AwsResourceBase
  name 'aws_cloudwatch_dashboard '
  desc 'Returns the configuration information and metadata of the specified cloudwatch dashboard.'

  example "
    describe aws_cloudwatch_dashboard(dashboard_name: 'DashboardName') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { dashboard_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:dashboard_name])
    raise ArgumentError, "#{@__resource_name__}: dashboard_name must be provided" unless opts[:dashboard_name] && !opts[:dashboard_name].empty?
    @display_name = opts[:dashboard_name]
    catch_aws_errors do
      resp = @aws.cloudwatch_client.get_dashboard({ dashboard_name: opts[:dashboard_name] })
      @dashboard = resp.to_h
      @dashboard_arn = @dashboard[:dashboard_arn]
      create_resource_methods(@dashboard)
    end
  end

  def resource_id
    @dashboard_arn
  end

  def dashboard_name
    return nil unless exists?
    @dashboard[:dashboard_name]
  end

  def exists?
    !@dashboard.nil? && !@dashboard.empty?
  end

  def to_s
    "Dashboard Name: #{@display_name}"
  end
end
