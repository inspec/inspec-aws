require "aws_backend"

class AWSRDSProxyEndpoint < AwsResourceBase
  name "aws_rds_db_proxy_endpoint"
  desc "Retrieves information about a patch baseline."

  example "
    describe aws_rds_db_proxy_endpoint(db_proxy_name: 'DB_PROXY_NAME', db_proxy_endpoint_name: 'DB_PROXY_ENDPOINT_NAME') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i[db_proxy_name db_proxy_endpoint_name])
    unless opts[:db_proxy_name] && !opts[:db_proxy_name].empty?
      raise ArgumentError,
            "#{@__resource_name__}: db_proxy_name must be provided"
    end
    unless opts[:db_proxy_endpoint_name] &&
             !opts[:db_proxy_endpoint_name].empty?
      raise ArgumentError,
            "#{@__resource_name__}: db_proxy_endpoint_name must be provided"
    end
    @display_name = opts[:db_proxy_endpoint_name]
    catch_aws_errors do
      resp =
        @aws.rds_client.describe_db_proxy_endpoints(
          {
            db_proxy_name: opts[:db_proxy_name],
            db_proxy_endpoint_name: opts[:db_proxy_endpoint_name]
          }
        )
      @res = resp.db_proxy_endpoints[0].to_h
      @db_proxy_endpoint_arn = @res[:db_proxy_endpoint_arn]
      create_resource_methods(@res)
    end
  end

  def resource_id
    @db_proxy_endpoint_arn
  end

  def db_proxy_endpoint_name
    return nil unless exists?
    @res[:db_proxy_endpoint_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "DB Proxy Endpoint Name: #{@display_name}"
  end
end
