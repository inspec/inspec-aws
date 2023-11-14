require "aws_backend"

class AWSApiGatewayBasePathMapping < AwsResourceBase
  name "aws_apigateway_base_path_mapping"
  desc "Describe a BasePathMapping resource."
  example <<-EXAMPLE
    describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
      it { should exist }
    end
  EXAMPLE

  def initialize(opts = {})
    opts = { domain_name: opts } if opts.is_a?(String)
    opts = { base_path: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i[domain_name base_path])
    unless opts[:domain_name] && !opts[:domain_name].empty?
      raise ArgumentError, "#{@__resource_name__}: domain_name must be provided"
    end
    unless opts[:base_path] && !opts[:base_path].empty?
      raise ArgumentError, "#{@__resource_name__}: base_path must be provided"
    end
    @display_name = opts[:base_path]
    catch_aws_errors do
      resp =
        @aws.apigateway_client.get_base_path_mapping(
          { domain_name: opts[:domain_name], base_path: opts[:base_path] }
        )
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def base_path
    return nil unless exists?
    @res[:base_path]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Base Path: #{@display_name}"
  end
end
