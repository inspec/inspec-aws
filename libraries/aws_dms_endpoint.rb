require "aws_backend"

class AWSDMSEndpoint < AwsResourceBase
  name "aws_dms_endpoint"
  desc "Returns information about the endpoints for your account in the current region."
  example <<-EXAMPLE
    describe aws_dms_endpoint(endpoint_arn: 'DMS_ENDPOINT_ARN') do
      it { should exist }
      its('endpoint_arn') { should eq 'DMS_ENDPOINT_ARN' }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { endpoint_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:endpoint_arn])

    raise ArgumentError, "#{@__resource_name__}: endpoint_arn must be provided" unless opts[:endpoint_arn] && !opts[:endpoint_arn].empty?
    @display_name = opts[:endpoint_arn]
    filter = { name: "endpoint-arn", values: [opts[:endpoint_arn]] }
    catch_aws_errors do
      resp = @aws.dmsmigrationservice_client.describe_endpoints({ filters: [filter] })
      @endpoints = resp.endpoints[0].to_h
      create_resource_methods(@endpoints)
    end
  end

  def resource_id
    @display_name
  end

  def endpoint_arn
    return nil unless exists?
    @endpoints[:endpoint_arn]
  end

  def exists?
    !@endpoints.nil? && !@endpoints.empty?
  end

  def to_s
    "Endpoint ARN: #{@display_name}"
  end
end
